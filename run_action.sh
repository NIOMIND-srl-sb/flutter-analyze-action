#!/bin/bash

# Get environment variables
TOKEN="$GITHUB_TOKEN_INPUT"
SHA="$GITHUB_SHA_ENV"
REPOSITORY="$GITHUB_REPOSITORY_ENV"
PR_NUMBER="$GITHUB_PULL_REQUEST_NUMBER_ENV"

# Check Dart format
echo "Checking Dart format..."
dart format --output=none --set-exit-if-changed .
if [ $? -ne 0 ]; then
    echo "Dart format check failed!"
    exit 1
fi

# Run Flutter Analyze and save output to a file
echo "Running Flutter Analyze..."
flutter analyze . > analyze_output.txt

ISSUE_DETECTED=0
while IFS= read -r line; do
  LINES+=("$line")
done < <(awk 'BEGIN{RS="\\\\n"}; {print}' analyze_output.txt)

for line in "${LINES[@]}"; do
    # Trim leading and trailing whitespaces
    trimmed_line=$(echo "$line" | awk '{$1=$1; print}')

    # Check if line contains info, warning or error
    if [[ $trimmed_line == *"info"* || $trimmed_line == *"warning"* || $trimmed_line == *"error"* ]]; then
        FILENAME=$(echo "$trimmed_line" | awk -F '•' '{print $3}' | awk -F ':' '{print $1}' | awk '{$1=$1;print}')
        LINE_NUMBER=$(echo "$trimmed_line" | awk -F '•' '{print $3}' | awk -F ':' '{print $2}')
        ISSUE=$(echo "$trimmed_line" | awk -F '•' '{print $2}')
        COMMENT="Flutter analyze issue:\n\`\`\`\n$trimmed_line\n\`\`\`"
        if [[ $FILENAME != "" && $LINE_NUMBER != "" ]]; then
            ISSUE_DETECTED=1

            URL="https://api.github.com/repos/$REPOSITORY/pulls/$PR_NUMBER/comments"
            BODY="{\"body\": \"$COMMENT\", \"commit_id\": \"$SHA\", \"path\": \"$FILENAME\", \"line\": $LINE_NUMBER, \"side\": \"RIGHT\"}"

            echo "URL:"
            echo "$URL"
            echo "Body:"
            echo "$BODY"

            curl -L \
              -X POST \
              -H "Accept: application/vnd.github+json" \
              -H "Authorization: Bearer $TOKEN" \
              -H "X-GitHub-Api-Version: 2022-11-28" \
              $URL \
              -d "$BODY"
        fi
    fi
done

exit $ISSUE_DETECTED

#!/bin/bash

# Get environment variables
TOKEN="$GITHUB_TOKEN"
REPOSITORY="$GITHUB_REPOSITORY"
PR_NUMBER="$GITHUB_PULL_REQUEST_NUMBER"
COMMIT_SHA="$GITHUB_SHA"

echo "GITHUB_TOKEN:"
echo "$GITHUB_TOKEN"
echo "GITHUB_REPOSITORY:"
echo "$GITHUB_REPOSITORY"
echo "GITHUB_PULL_REQUEST_NUMBER:"
echo "$GITHUB_PULL_REQUEST_NUMBER"
echo "GITHUB_SHA:"
echo "$GITHUB_SHA"

echo "TOKEN:"
echo "$TOKEN"
echo "REPOSITORY:"
echo "$REPOSITORY"
echo "PR_NUMBER:"
echo "$PR_NUMBER"
echo "COMMIT_SHA:"
echo "$COMMIT_SHA"

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
    if [[ $line == *" info"* || $line == *" warning"* || $line == *" error"* ]]; then
        ISSUE_DETECTED=1
        FILENAME=$(echo "$line" | awk -F '•' '{print $3}' | awk -F ':' '{print $1}' | awk '{$1=$1;print}')
        LINE_NUMBER=$(echo "$line" | awk -F '•' '{print $3}' | awk -F ':' '{print $2}')
        ISSUE=$(echo "$line" | awk -F '•' '{print $2}')
        COMMENT="Flutter analyze issue:\n\`\`\`\n$line\n\`\`\`"

        URL="https://api.github.com/repos/$REPOSITORY/pulls/$PR_NUMBER/comments"
        BODY="{\"body\": \"$COMMENT\", \"commit_id\": \"$COMMIT_SHA\", \"path\": \"$FILENAME\", \"line\": $LINE_NUMBER, \"side\": \"RIGHT\"}"

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
done

exit $ISSUE_DETECTED

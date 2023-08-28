# Flutter Analyze GitHub Action

This GitHub Action runs `flutter analyze` on your Flutter project and posts comments on the Pull Request for any detected issues.

## Features

- Automatically sets up Flutter.
- Checks Dart code formatting.
- Analyzes the Flutter project for issues.
- Posts individual comments on the Pull Request for detected issues.

## Environment Variables

- GITHUB_TOKEN: GitHub Token used for posting comments on Pull Requests.
- GITHUB_REPOSITORY: Owner and repository name.
- GITHUB_PULL_REQUEST_NUMBER: Number of the pull request being analyzed.
- GITHUB_SHA: SHA of the commit being analyzed.

## Usage

To use this action, create a `.github/workflows/flutter_analyze.yml` (or similar) file in your repository:

```yaml
name: Flutter Analyze

on:
  pull_request:
    types:
      - opened
      - synchronize

jobs:
  analyze:
    name: Run Flutter Analyze
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@v2.4.2

      # Using your public action
      - name: Run Public Flutter Analyze Action
        uses: NIOMIND-srl-sb/flutter-analyze-action@v1.0.9
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
```

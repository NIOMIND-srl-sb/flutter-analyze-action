# Flutter Analyze GitHub Action

This GitHub Action runs `flutter analyze` on your Flutter project and posts comments on the Pull Request for any detected issues.

## Features

- Automatically sets up Flutter.
- Checks Dart code formatting.
- Analyzes the Flutter project for issues.
- Posts individual comments on the Pull Request for detected issues.

## Environment Variables

- GITHUB_TOKEN: GitHub Token used for posting comments on Pull Requests.
- GITHUB_REPOSITORY_OWNER: Owner of the repository.
- GITHUB_REPO: Repository name.
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
    - name: Checkout Repository
      uses: actions/checkout@v2
      
    - name: Set up Flutter
      uses: subosito/flutter-action@v2

    - name: Execute Flutter Analyze Action
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GITHUB_REPOSITORY_OWNER: ${{ github.repository_owner }}
        GITHUB_REPO: ${{ github.repository }}
        GITHUB_PULL_REQUEST_NUMBER: ${{ github.event.pull_request.number }}
        GITHUB_SHA: ${{ github.sha }}
      run: ./run_action.sh
```

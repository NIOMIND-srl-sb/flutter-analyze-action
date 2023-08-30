# Changelog

All notable changes to the "Flutter Analyze GitHub Action" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.20] - 2023-08-30

### Fixed

- Documentation:
  - Update `README.md`.

## [1.0.19] - 2023-08-30

### Fixed

- Fixed bug in script for output of flutter analyze (remove any space).

## [1.0.18] - 2023-08-30

### Fixed

- Fixed bug for input and variables name.
- Documentation:
  - Update `README.md` for input and envairoment variables.

## [1.0.17] - 2023-08-30

### Fixed

- Fixed bug for input and remove commitId from input.

## [1.0.16] - 2023-08-30

### Fixed

- Fixed bug for input and chaneg varibale names.

## [1.0.15] - 2023-08-30

### Fixed

- Fixed bug print for input.

## [1.0.14] - 2023-08-29

### Fixed

- Fixed bug where try to get commit id from input.

## [1.0.13] - 2023-08-28

### Fixed

- Fixed bug where try to find info or error or warning in the output of flutter analyze.

## [1.0.12] - 2023-08-28

### Fixed

- Remove print to debug.

## [1.0.11] - 2023-08-28

### Fixed

- Add some print to debug.

## [1.0.10] - 2023-08-28

### Fixed

- Add some print to debug.

## [1.0.9] - 2023-08-28

### Fixed

- Add GitHub Path to run action.

## [1.0.8] - 2023-08-28

### Refcator

- Remove comments from code.

## [1.0.6] - 2023-08-27

### Fixed

- Fixed a bug where for file permissions to lunch run action.

## [1.0.5] - 2023-08-27

### Fixed

- Fixed a bug where for file permissions to lunch run action.

## [1.0.4] - 2023-08-27

### Fixed

- Fixed a bug where for file permissions to lunch run action.

## [1.0.3] - 2023-08-30

### Fixed

- Fixed a bug where for file permissions to lunch run action.

## [1.0.2] - 2023-08-27

### Fixed

- Fixed a bug where the `GITHUB_TOKEN` environment variable was not being set correctly.

## [1.0.1] - 2023-08-27

### Fixed

- Fixed a bug where the `GITHUB_REPOSITORY` environment variable was not being set correctly.
- Fixed a bug where the `GITHUB_REPOSITORY_OWNER` environment variable was not being set correctly.
- Fixed a bug where the `GITHUB_REPO` environment variable was not being set correctly.
- Fixed documentation in `README.md` for example to used.

## [1.0.0] - 2023-08-27

### Added

- Initial release of the Flutter Analyze GitHub Action.
- Automatic setup of Flutter using `subosito/flutter-action@v2`.
- Dart code formatting check using `dart format`.
- Analysis of the Flutter project using `flutter analyze`.
- Posting individual comments on the Pull Request for detected issues.
- Basic error handling and feedback for the user.
- Documentation:
  - `README.md` for usage instructions.
  - `CONTRIBUTING.md` for contribution guidelines.
  - `LICENSE` (MIT License).

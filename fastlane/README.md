fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios distribute
```
fastlane ios distribute
```
Push a new beta build to Firebase App Distribution
### ios beta
```
fastlane ios beta
```
Push a new beta build to Firebase App Distribution
### ios run_tests_app
```
fastlane ios run_tests_app
```
Run UI and Unit Tests
### ios run_build_app
```
fastlane ios run_build_app
```
Build Only
### ios run_snapshot
```
fastlane ios run_snapshot
```
Generates screenshots
### ios run_swiftlint
```
fastlane ios run_swiftlint
```
SwiftLint
### ios run_slather
```
fastlane ios run_slather
```
Slather
### ios run_codecov_reporter
```
fastlane ios run_codecov_reporter
```
Codecov
### ios run_sonar
```
fastlane ios run_sonar
```
Code Quality and Security

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

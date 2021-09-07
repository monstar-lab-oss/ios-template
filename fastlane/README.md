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
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Run unit test.
### ios alpha
```
fastlane ios alpha
```
Build alpha ipa
### ios beta
```
fastlane ios beta
```
Build beta ipa
### ios prod
```
fastlane ios prod
```
Build production ipa
### ios build_deploy
```
fastlane ios build_deploy
```
Build and deploy ipa

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

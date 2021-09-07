Please do the following to make fastlane builds work in CI environment: 
- [ ]  convert your dist.p12(your private key for distribution) to base64 using cat dist.p12 | base64 | pbcopy and put it inside CI Environment as DIST_KEY_BASE64 
- [ ]  convert your dist.cer(your certificate for distribution) to base64 using cat dist.cer | base64 | pbcopy and put it inside CI Environment as DIST_CER_BASE64 
- [ ]  put password for dist.p12 in DIST_KEY_PASSWORD variable
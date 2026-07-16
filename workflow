- Application running and deployed in production
- Frontier model identifies a CVE (CVE-2026-1234) in the important-core-v2.4.1-rc1 package
- The automated workflow will then check if there is a patched version of this package in Lightwell using the API
- From the API response, the Lightwell repository contains a patched version of this package: important-core-v2.4.1-lw
- The pom.xml file gets updated with the lightwell repository and the patched package.
At this point, the "Start CI/CD pipeline" button appears.
Whe clicked, create log entries for the following:
- Updated patch from Lightwell downloaded
- Package credentials verified
- Package cryptographicly signed - verified
- Re-build application with the new package
- Start deployment process 
- Start blue/green deployment
- Testing of blue deployment: Success
- Testing of green deployment: Success




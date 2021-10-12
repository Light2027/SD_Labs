# Lab 1
## Tasks:
+ Create an ARM Template: azuredeploy.json
+ Create and use a Parameter file with the ARM Template: azuredeploy.parameters.json
+ Create a README.md file
+ Use the ARM Template to Deploy a simple Node.JS application: See app => https://github.com/Light2027/Node.JS_HelloWorld_Azure_CI

## How to deploy:
You can set most of the parameters in "azuredeploy.parameters.json", but there are some such as the resource groups name that must be set in the bash script.
run the bash script:
```PowerShell
bash deploymentScript.sh
```

There are some parameters that I put in here so that I may reuse it in the future.

## Design choices:
I originally wanted to use the PowerShell Interface of Azure but it did not wish to cooperate no matter what, so I later switched to the CLI (Command Line Interface).  
Port 8080 is used in the App as Azure use that on my end by default, and it did not find the original port I set (3000). This made it so that even though the web app ran it did not display "Hello world".  
The "reserved" property of the service plan/server farm had to be set to *true* as otherwise it only displayed that it is a linux machine but did not act like one...

## Problems with Azure:
I am assuming there is a valid reason for having to set the "reserved" property to *true* in order to make the machine act like a linux machine, but it would be nice if it was set to *true* by default so that those who know and care about what it does can set it to false and those who are new to this are not confused by being told that the machine they set to use linux is not using linux.  
Error messages in general are barely of any use.  
Reason:
+ 400 - Bad Request without any message is never a good idea. => This is the reason why I am doing the deployment in the bash script instead of the arm template...
+ Events without any details what so ever on the Web Portal (There is no way to know what was not found if the portal does not tell me.)
+ If one is matching an input string using RegEx then the Input that was validated should also be included not just the pattern.
# Lab 1
## Tasks:
+ Create an ARM Template: azuredeploy.json
+ Create and use a Parameter file with the ARM Template: azuredeploy.parameters.json
+ Create a README.md file
+ Use the ARM Template to Deploy a simple Node.JS application: See app => https://github.com/Light2027/Node.JS_HelloWorld_Azure_CI

## How to deploy:
You can set most of the parameters in "azuredeploy.parameters.json", but some must be set in the bash script, such as the resource groups' name.
run the bash script:
```PowerShell
bash deploymentScript.sh
```

There are some parameters that I put in there so that I may reuse them in the future.

## Design choices:
I originally wanted to use the PowerShell Interface of Azure, but it did not wish to cooperate no matter what, so I later switched to the CLI (Command Line Interface).  
Port 8080 is used in the App as Azure used that on my end by default, and it did not find the original port I set (3000). This made it so that it did not display "Hello world" even though the web app ran.  
The "reserved" property of the service plan/server farm had to be set to *true* as otherwise, it only displayed that it is a Linux machine but did not act like one...

## Problems with Azure:
I am assuming there is a valid reason for having to set the "reserved" property to *true* to make the machine act like a Linux machine. Still, it would be nice if it was set to *true* by default so that those who know and care about what it does can set it to false, while those who are new to this are not confused by being told that the machine they set to use Linux is not using Linux.  
Error messages, in general, are not very useful.  
Reason:
+ 400 - Bad Request without any message is never a good idea. => This is the reason why I am doing the deployment in the bash script instead of the arm template...
+ Events without any details whatsoever on the Web Portal (There is no way to know what was not found if the portal does not tell me.)
+ If one matches an input string using RegEx, then the Input that was validated should also be included, not just the pattern, e.g. Input: "ab" did not match pattern "[ac]*".

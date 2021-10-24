# Links:

## Link to Azure DevOps:
https://dev.azure.com/112966/Lab2

## Link to Node App:
https://github.com/Light2027/AzureDevOps_Node.JS

## Links to Tutorials followed:
+ https://www.digitalocean.com/community/tutorials/test-a-node-restful-api-with-mocha-and-chai
+ https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/javascript?view=azure-devops&tabs=code

## Links that helped:
+ https://stackoverflow.com/questions/50372866/mocha-not-exiting-after-test
+ https://docs.microsoft.com/en-us/answers/questions/477716/how-to-resolve-34no-hosted-parallelism-has-been-pu.html

# The Process:
## Summary:
This was not so bad. The things that made the experience uncomfortable were based on decisions that are understandable.

## Detailed description:
### Test deployment:

First and foremost I set the Azure DevOps repository to public, which did not have parallel jobs for me to use, so my deployment failed. To Solve this I simply set the repository to private.
After that, made a mistake in my unit test, namely I did not add the --exit argument to mocha.
Afterwards I started my webapp in the build phase instead of the deployment phase.
Finally I forgot to create the webapp to which my application was to be deployed on azure.

### Real deployment:
In this phase I reused my original deployment as the release pipeline, so I only needed to create a secondary pipeline which was to be triggered everytime a so called "dev" branch got updated. I decided that there would be no testing for the "dev" branch.

### Triggers:
The triggers are set so, that whenever the "dev" branch is checked-out, it is automatically deployed without testing.
In the meanwhile the "main" branch is considered the release version, whenever it is checked-out, it will be first unit tested, and only then deployed.
This was tested, as one can see in the history of the pipelines.

# Things that are not okay:
+ Having to export the application for Mocca.

+ Azure DevOps having to commit to a repository to work.  
The repository should not know that a CI/CD exists.
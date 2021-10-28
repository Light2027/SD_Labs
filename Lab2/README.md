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
+ https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/javascript?view=azure-devops&tabs=code

# Tools:
+ Visual Studio Code
+ Git bash
+ GitHub
+ Azure DevOps
+ Azure Portal

# The Process:
## Summary:
The Azure DevOps platform also suffers from the same error handling issue as the Azure Platform. In addition to that, it is not very clear, as you can do nearly everything in the pipeline's section, but there is the releases section which is not entirely connected to the pipeline's section, yeah...
For the required images, see "./Images". I also made the project public at the end.
I kept the Node.js app simple as that was not the main focus of this exercise.

## Detailed description:
### Test deployment:
First and foremost, I set the Azure DevOps repository to public, which did not have parallel jobs for me to use, so my deployment failed. To solve this, I simply set the repository to private.
After that, I made a mistake in my unit test. Namely, I did not add the --exit argument to mocha.
Afterwards, I started my web app in the build phase instead of the deployment phase...
Finally, I forgot to create the web app to which my application was to be deployed on Azure.

On a side note, I always modified the ".yml" files to fit my taste, such as using the latest Node version Azure can use, namely Node 14, and not building my application as there is no need to do so etc.

### Real deployment:
In this phase, I reused my original deployment as the release pipeline, so I only needed to create a second pipeline that was to be triggered every time a so-called "dev" branch got updated.

#### The Release Pipeline:
I have not noticed first that there is a release section on Azure DevOps. However, after I did, I deleted the Deploy parts in the ".yml" files and used the tools provided in the release section to handle the deployment.
Here I created a deployment pipeline with two artefacts and two stages, one dev and one release. I set the dev one to trigger after a new release of the development artefact is available. At the same time, I set the release one to manual deployment. Here I also encountered an issue. Namely, my stages both wanted to build both artefacts, which caused a collision, and Azure did not know what to deploy, so I had to change the settings so that the dev stage only downloaded the dev artefact while the release only downloads the release artefact.
After that, I experimented a bit with setting the repository to public, but then I could not build the artefacts again. So I decided to wait until the end to do so.
I also tried to add the publish unit tests task to my stages, where I configured the release one to fail if the tests fail.
Then I decided to simply add them to the ".yml" files.

### Triggers:
The triggers are set so that it is automatically deployed whenever the "dev" branch is checked-out.
In the meanwhile, the "main" branch is considered the release version. Therefore, it has to be manually deployed, as agreed upon.

# Release Docs:
A new version should only be released from the main branch. It also must succeed in all of its unit tests before it is deployed. It will not deploy if any of them fails.

# Things that are not okay:
+ Having to export the application for Mocca.

+ Azure DevOps having to commit to a repository to work.  
The repositorys' code should not know that a CI/CD exists.

+ There was this small thing that was just slightly inconvenient but still worth mentioning. On Azure, when a new pipeline is first deployed, one needs to give it permission in the deployment phase so that it can access the web app or whatever resource it deploys to. The popup for this does not appear when one overlooks the deployment starting from the build phase. One has to go back to the deployment history and then go back into the deployment to see it. Otherwise, one will stare at a black screen forever.

+ pipelines and releases which contain release pipelines and have similar features, this is confusing.

+ But the most frustrating of all is still error handling. "Error: More than one package matched with specified pattern: D:\a\r1\a\**\*.zip. Please restrain the search pattern." Like what would it cost them to list out the problematic files? Or not even all the files, just the two that led to the collision? I am sure they have their names, so what is stopping them from doing that?
# terraform-azure
#### 1).Creating an Azure DevOps Account(https://dev.azure.com)
#### 2).Creating a new Azure DevOps project
#### 3).Initializing the Azure DevOps Repo
     * Import a repository of the Terraform Code to the Azure DevOps Repos
#### 4).Installation Required to perform Terraform Task in Azure DevOps
    * Go to Organization Settings Install the Terraform Build & Release Tasks extension from Marketplace
    * Click on Extensions
    * Click on Browser MarketPlace
    * Install the Azure Pipelines Terraform Tasks by Charles Zipp
#### 5).Creating a new Azure DevOps Build Pipeline
    * click on the Create Pipeline button and select Other Git to create a pipeline.
    * Then select the Empty job template, locate on the top of the screen.
    * Select Agent Specification as ubuntu or windows
    * click the plus sign (+) and add the copy files task. Add a job with type Copy Files.
    * Choose the Source folder and choose to copy all content.We will set the target folder as $(build.artifactstagingdirectory)/(Enter fileName which we choose in the Source folder)
    * Add a job with type Publish Build Artifacts and leave it with default parameters
    * In the Triggers tab, check the Enable continuous integration checkbox and click on the Save & queue button and Then click the Save and run button to launch our pipeline.
#### 6).Creating an Azure DevOps Release Pipeline
    * On this stage, we will use the artifact generate on the build pipeline and create a Stage task with these following tasks
    * click on the New pipeline button to create a new Azure DevOps Release Pipeline and Select a template page, we choose an Empty job template
    * Add an artifact page, we choose the Build button and configure the Source (build pipeline) to use the build pipeline created on the previous step.
    * click the Add button, and then click on the lightning icon and activate the CD (Continuous Deployment)
##### Configuring the Stage
    * Click on the Stage 1 button to rename the stage name if you want and close the Stage name page and then click on the 1 job, 0 task link on Terraform button..
    * Click on the plus sign (+), next to the Agent job and search for terraform.
    * Add Terraform Installer and Terraform CLI
    * In Terraform CLI we can choose the commands(Init,Validate,Paln,Apply)
    * Configure the init Command, the Configuration Directory to use the drop/Terraform folder of the Build Pipeline and select local in the Backend Type.
    * select the Terraform CLI task and click on the Add button next to it.Then configure the Terraform Plan, setting the Command to plan, the Configuration Directory to use the drop/Terraform folder of the Build Pipeline and Environment Azure Subscription.
    * select the Terraform CLI task and click on the Add button next to it.Then configure the Terraform Apply task, setting the Command to apply, the Configuration Directory to use the drop/Terraform folder of the Build Pipeline and Environment Azure Subscription
    * Click on the Save and then click on the Create release button.
    

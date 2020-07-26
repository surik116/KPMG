# Setup

The terraform code has been split into 
- VPC module
- VPC
- Bastion (EC2)

Terraform workspaces are used to maintain segregation between different environments. ```terraform.workspace``` is used in the code for easy segregation of environments.

### VPC Module
This module encapsulates the skeleton for building a VPC. The outputs from this module are used in VPC and more meaningful outputs are listed to bed used across the infrastructure.

### VPC
The IP address ranges
- Dev ```10.1.0.0/16```
- Test ```10.2.0.0/16```
- Prod ```10.3.0.0/16```

### Bastion
The main entry point to the environment with access restricted through IP whitelisting.

### Remote state
In this exercise, terraform state is remotely stored in an S3 bucket

### AWS Profiles
Different AWS profiles have to be setup pointing to different environments

### Running the scripts
- ```export AWS_profile=dev```
- ```terraform init```
- ```terraform workspace new dev``` This creates a new workspace. It is ideal to create a workspace per environment. In this case dev, test and prod.
- ```terraform plan``` Show the terraform plan that will be implemented. It is a good point to check the resources that are going to be created and validate.
- ```terraform apply``` Applies the plan that was displayed earlier and creates the resources for the selected environment

The above steps have to be performed for each resource section. This keeps the state files segregated and easy to manage.
### Other commands
- ```terraform workspace list``` Lists all workspaces that have been created
- ```terraform workspace select dev``` Selects the required workspace
 
# dai-deployment
Tool for deployment of H2O - Driverless AI to AWS

## Description
The project is inteded to deploy Driverless AI product to AWS. No preconfiguration is needed on AWS. All necessary resources will be created during deployment process. Application will be running on port `12345`.

## Input parameters
* access_key
* secret_key
* instance_type. Defauilt is `"m5a.2xlarge"`
* volume_size. Defauilt is `"1000"`
* ssh_key_path. Default is `"~/.ssh/id_rsa"`

### Default parameters
All default parameters is stored in `terraform.tfvars` file. You can also specify these parameters during `terraform apply` operation by specifying `-var instance_type=m5a.2xlarge`. If you also want make `Access key` and `Secret key` default, just create `secrets.tfvars` file in the `terraform` folder, add following content and specify you Access key and Secret key in the file

```
access_key = "YOUR AWS ACCESS KEY"
secret_key = "YOUR AWS SECRET KEY"
```
After that you can you terraform commands like this: 
`terraform apply -var-file="secrets.tfvars"`
`terraform destroy -var-file="secrets.tfvars"`


## Output parameters
* Public IP address of the server.
* SSH key path on your local machine which can be used to access the server.

## Requirements
* Terraform >= 0.12

## Usage
Execute following actions:
* Navigate to `terraform` directory 
* `terraform init` - will download necessary libraries.
* `terrafor apply` - Will do the actual magic. Check _Input parameters_ section for specifying input values.

After successful execution of all commands you can access to application with `http://PUBLOC_IP_ADDRESS:12345`
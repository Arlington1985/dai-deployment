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
* major_version. Default is `"1.7.0"`
* minor_version. Default is `"214"`
* cuda_version. Default is `"10.0"`
* cuDNN_version. Default is `"7.6.0.64"`
* config_file. Default is empty. Optionally you can specify path to `config.toml` in you local machine. It will replace application config file before launch. 

### Default parameters
All default parameters is stored in `terraform/terraform.tfvars` file. You can also specify these parameters during `terraform apply` operation by specifying `-var instance_type=m5a.2xlarge`. If you also want make `Access key` and `Secret key` default, just create `terraform/secrets.tfvars` file, add following content and specify you Access key and Secret key in the file

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


## TODO
* Add validation of input variables. Terraform doesn't have any functionality to provide such validation out of the box. There is some workaround but at the end you can't build complex validation because different major minor versions depend on different version of CUDA and CUDNN libraries. My choose is to build command line tool which will execute terraform command after validation.
* Current functionality only support docker installation with on top of the RHEL OS. But DAI has another options which would be better to include them to this project.
* Add load balancer and autoscaling before ec2 instance in order to provide horizontal scaling. 
# Candidate Challenge
Create a few virtual machines, each with a webserver running that is accessible only to the other machinesin the test pool. Only the ports that are required to host and communicate with the webserver should be open on the virtual machines. The root URL on each webserver should return a simple informational page that displays the current operating system version, date, time, andIP address.This small proof of concept solution should be able to scale out across many more machines, with minimal human interaction. 

## Layout
The `examples` directory contains the full integration of various Terraform modules.  This is where a user would run `terraform apply` to provision and configure their desired system.  The `modules` directory contains the individual modules used to create discrete cloud proisioned pieces of the total solution.  These modules are tied together by a parent module located in the `examples` directory.  The modules and examples are organized by cloud provider.


## AWS vs OCI
When I started the challenge I began with attempting to provision OCI resources.  After a while I was concerned that I would not be able to sufficiently learn the OCI API well enough to complete the challenge in the time alotted.  At that point I stopped working on OCI and instead migrated my solution to AWS (a provider I am much more familiar with.)  As a result the AWS example is my (mostly) completed challenge.  I decided to keep the OCI work in the repo as well as for posterity's sake.

# Running the AWS module
To run the AWS module cd into `examples/aws`.  You will need an AWS account with programatic access.  Your `access_key_id` and `access_secret_key` should be located in your `.aws/credentials` file as that's where the AWS provider will expect it. After filling out the terraform.tfvars file run `terraform init` followed by `terraform apply`

There are 3 required parameters listed in the terraform.tfvars file: 

    - `region` is the AWS region in which resources (such as the compute instances) are to be deployed. 
    - `instance_count` is the number of compute instances (or VMs) you wish to deploy.  You can deploy as little as a single instance or as many intances as  AWS will allow.
    - `ssh_access` is a boolean value that indicates whether or not you need ssh access to these VMs.  

My interpretation of the challenge was that ONLY the ports needed for the web server are to be opened therefore port 22 and thus ssh access in general would not be allowed.  By setting `ssh_access` to false you achieve this by not only removing AWS security group rules that allow port 22 access on the VMs but it also closes port 22 and disables openssh service itself inside the instances.  In my own testing it was difficult to validate the other portions of the challenge prompt without ssh access so I created this variable as a way to validate that the other challenge requirements were met (mainly that each vm had a web server running that was ONLY accessable by the other VMs.)

# Running the OCI module
The OCI module is an incomplete attempt at the challenge with OCI resources.  Currently this module only creates a VCN, subnet, and an arbitrary number of compute instances (VMs).  Theoretically it also installs a web server on the VMs but I don't believe I configured the firewall to allow egress to pull the package so I don't believe that portion was completed.

## Results
Running the AWS module will give you an abritrary number of VMs that each have a web server intalled.  The webserver is only accessable by the other VMs in the network.  Network access was controlled using AWS security rules providing access on port 80 to and from machines within that network.  External access to the VMs via either http, https, ssh, or any other method is not allowed. This solution is very scalable.  To increase the number of VMs you would like provisioned, simply increase the `instance_count` variable in the tfvars file.  Due to the 4 hour time limitation I was not able to achieve the final part of the challenge: `The root URL on each webserver should return a simple informational page that displays the current operating system version, date, time, andIP address`though I'm sure if given more time I could have accomplished that.

I really enjoyed working on this challenge.  If you have any questions or would like a walkthrough, please let me know.  Thank you for your time.
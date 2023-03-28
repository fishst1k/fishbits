## IAC
This is the infra as code to build out the required peices to host our WordPress site in AWS.

### Setup
1. Create your AWS account
2. Setup an IAM user with proper permissions
3. Setup the AWS CLIv2 profile with the IAM user creds
4. `AWS_PROFILE=<profile> terraform init`
5. `AWS_PROFILE=<profile> terraform plan`
6. `AWS_PROFILE=<profile> terraform apply`

### Cleanup
`AWS_PROFILE=<profile> terraform destroy`

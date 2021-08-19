# Overview

At the moment, AWS ALBs can't be associated with elastic IPs. 
This module provides a way to resolve this problem by implementing the solution based on the following article:
https://aws.amazon.com/blogs/networking-and-content-delivery/using-static-ip-addresses-for-application-load-balancers/

### Main resources created

- Public facing NLB with a set of elastic IPs, one for each public subnet 
- Internal ALB
- S3 access log bucket for both LBs
- Lambda function that is responsible for the attachment of ALB IPs to the NLB target group
- S3 bucket and cloudwatch resources that accompany the lambda function above

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_sg\_id | ALB security group id | `string` | n/a | yes |
| deletion\_protection\_enabled | Indicates if load balancers can be deleted | `bool` | n/a | yes |
| invocations\_before\_deregistration | The number of required Invocations before an IP address is de-registered. | `number` | `3` | no |
| max\_lookup\_per\_invocation | The max times of DNS lookup per invocation. | `number` | `50` | no |
| name | Solution name | `string` | n/a | yes |
| private\_subnets | List of private subnet ids | `list(string)` | n/a | yes |
| public\_subnets | List of public subnet ids | `list(string)` | n/a | yes |
| tags | Map of tags that should be applied to all resources | `map(string)` | n/a | yes |
| vpc\_id | VPC that will host this solution | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| external\_nlb\_arn | ARN of the externally facing NLB |
| external\_nlb\_dns\_name | DNS name of the externally facing NLB |
| external\_nlb\_zone\_id | Zone id of the externally facing NLB |
| internal\_alb\_arn | ARN of the internally facing ALB |
| internal\_alb\_dns\_name | DNS name of the internally facing ALB |
| internal\_alb\_zone\_id | Zone id of the internally facing ALB |

# CICD with Docker-Compose and AWS DevOps

## Components Involved
* AWS
  * CodeCommit
  * CodeBuild
  * CodeDeploy
  * CodePipeline
  * ECR
* EC2

## Architecture 
![Docker-Compose_CICD_Architecture](https://github.com/supersaiyane/CICD-with-Docker-Compose/blob/main/Architecture_Docker-Compose_Automation.png)


## Flow of the Architecture

* The developer pushes the code to the service repository. With the help of CloudWatch events, CodePipeline will initiate the following steps
  * CodeBuild will prepare the image and send it to ECR. Additionally, it will generate a JSON artifact containing information on the latest image tag.
  * CodeDeploy will then deliver this artifact to the designated location on the EC2 instances. It will execute the after-install and before-install scripts, as explained in later sections.
  * Once the scripts have been executed successfully, Docker-Compose will incorporate the new service image, and the changes will begin to take effect.

## For Complete Guide please follow the link below 

* [Automating Docker-Compose deployments, backed by Nginx on EC2 with AWS DevOps](https://medium.com/@gurpreet.singh_89/automating-docker-compose-deployments-backed-by-nginx-on-ec2-with-aws-devops-979f85d61d9a)

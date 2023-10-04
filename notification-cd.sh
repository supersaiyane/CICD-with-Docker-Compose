#check the current image tag version from Docker-compose file
old_image_string="$(grep -P \^\.\*<account_id>.dkr.ecr.us-east-2.amazonaws.com/PwaApp\.\*\$ /home/ubuntu/Deployment/docker-compose.yaml)"
echo $old_image_string
old_image_tag=${old_image_string##*:}
echo $old_image_tag

#check the current image tag version from Docker-compose file
latest_image_string="$(grep -P \^\.\*<account_id>.dkr.ecr.us-east-2.amazonaws.com/PwaApp\.\*\$ /home/ubuntu/Services/PwaApp/imagedefinitions.json)"
echo $latest_image_string
latest_image_tag=$(echo ${latest_image_string##*:} | tr -dc '0-9')
echo $latest_image_tag

#Replacing the latest tag with old tag
sed -i 's/PwaApp:'$old_image_tag'/PwaApp:'$latest_image_tag'/g' /home/ubuntu/Deployment/docker-compose.yaml

#for verification purpose-PwaApp
image_number_2="$(grep -P \^\.\*<account_id>.dkr.ecr.us-east-2.amazonaws.com/PwaApp\.\*\$ /home/ubuntu/Deployment/docker-compose.yaml)"
echo $image_number_2

#executing docker-compose commands and login ECR
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.us-east-2.amazonaws.com
cd /home/ubuntu/Deployment
docker-compose ps
docker-compose -f docker-compose.yaml up -d --force-recreate --no-deps dcanotification

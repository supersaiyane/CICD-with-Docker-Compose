#check the current image tag version from Docker-compose file
old_image_string="$(grep -P \^\.\*<account_ID>.dkr.ecr.us-east-2.amazonaws.com/notification-service\.\*\$ /home/ubuntu/ops/docker-compose.yaml)"
echo $old_image_string
old_image_tag=${old_image_string##*:}
echo $old_image_tag

#check the current image tag version from Docker-compose file
latest_image_string="$(grep -P \^\.\*<account_ID>.dkr.ecr.us-east-2.amazonaws.com/notification-service\.\*\$ /home/ubuntu/iambatman/notification/imagedefinitions.json)"
echo $latest_image_string
latest_image_tag=$(echo ${latest_image_string##*:} | tr -dc '0-9')
echo $latest_image_tag

#Replacing the latest tag with old tag
sed -i 's/notification-service:'$old_image_tag'/notification-service:'$latest_image_tag'/g' /home/ubuntu/ops/docker-compose.yaml

#Replacing the latest tag with old tag for grpc service
#sed -i 's/notification-grpc:'$old_image_tag'/notification-grpc:'$latest_image_tag'/g' /home/ubuntu/ops/docker-compose.yaml

#for verification purpose-auth_service
image_number_2="$(grep -P \^\.\*<account_ID>.dkr.ecr.us-east-2.amazonaws.com/notification-service\.\*\$ /home/ubuntu/ops/docker-compose.yaml)"
echo $image_number_2

#for verification purpose-auth_grpc
#image_number_3="$(grep -P \^\.\*<account_ID>.dkr.ecr.us-east-2.amazonaws.com/notification-grpc\.\*\$ /home/ubuntu/ops/docker-compose.yaml)"
#echo $image_number_3

#executing docker-compose commands and login ECR
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin <account_ID>.dkr.ecr.us-east-2.amazonaws.com
cd /home/ubuntu/ops
docker-compose ps
docker-compose -f docker-compose.yaml up -d --force-recreate --no-deps notification-service

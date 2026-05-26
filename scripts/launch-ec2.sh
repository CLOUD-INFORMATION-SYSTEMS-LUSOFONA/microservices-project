#!/bin/bash

# Variables
AMI_ID="ami-023adbbb2c440f837" # Amazon Linux 2023
INSTANCE_TYPE="t3.micro"
KEY_NAME="miguelrodr1" # Your key pair name
SECURITY_GROUP="sg-06432caa9c28ee230" # Your security group ID
SUBNET_ID="subnet-00fc19892a25e0ed2" # Your public subnet ID

echo "Launching EC2 instance..."

# Launch instance
INSTANCE_ID=$(aws ec2 run-instances \
 --image-id $AMI_ID \
 --instance-type $INSTANCE_TYPE \
 --key-name $KEY_NAME \
 --security-group-ids $SECURITY_GROUP \
 --subnet-id $SUBNET_ID \
 --associate-public-ip-address \
 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=week6-instance}]' \
 --query 'Instances[0].InstanceId' \
 --output text)

echo "Instance ID: $INSTANCE_ID"

# Wait for instance to be running
echo "Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
 --instance-ids $INSTANCE_ID \
 --query 'Reservations[0].Instances[0].PublicIpAddress' \
 --output text)

echo "Instance is running!"
echo "Public IP: $PUBLIC_IP"
echo "Connect with: ssh -i ${KEY_NAME}.pem ec2-user@${PUBLIC_IP}"
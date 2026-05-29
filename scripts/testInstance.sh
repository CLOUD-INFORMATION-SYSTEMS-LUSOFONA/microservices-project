#!/bin/bash

# Região AWS
REGION="eu-central-1"

# ID da VPC
VPC_ID="vpc-0114810450232daba"

# Subnet pública
PUBLIC_SUBNET_ID="subnet-00fc19892a25e0ed2"

# Key pair
KEY_NAME="miguelrodr1"

# Tag
CREATED_BY="miguelrodr1gues"

# =========================
# AMI mais recente Amazon Linux 2
# =========================
AMI_ID=$(aws ec2 describe-images \
 --owners amazon \
 --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
           "Name=state,Values=available" \
 --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
 --output text \
 --region $REGION)

echo "AMI escolhida: $AMI_ID"

# =========================
# Security Group
# =========================
MY_IP=$(curl -s https://checkip.amazonaws.com)/32

SG_ID=$(aws ec2 describe-security-groups \
  --filters "Name=group-name,Values=week5-ssh-sg" "Name=vpc-id,Values=$VPC_ID" \
  --query "SecurityGroups[0].GroupId" \
  --output text \
  --region $REGION)

if [ "$SG_ID" = "None" ] || [ -z "$SG_ID" ]; then
  SG_ID=$(aws ec2 create-security-group \
    --group-name week5-ssh-sg \
    --description "Week 5: allow SSH from my IP" \
    --vpc-id $VPC_ID \
    --tag-specifications "ResourceType=security-group,Tags=[{Key=CreatedBy,Value=$CREATED_BY}]" \
    --query 'GroupId' \
    --output text \
    --region $REGION)
fi

# Autorizar SSH (ignora erro se já existir)
aws ec2 authorize-security-group-ingress \
  --group-id $SG_ID \
  --protocol tcp \
  --port 22 \
  --cidr $MY_IP \
  --region $REGION 2>/dev/null || echo "Ingress rule já existe"

# =========================
# Lançar instância EC2
# =========================
INSTANCE_ID=$(aws ec2 run-instances \
 --image-id $AMI_ID \
 --instance-type t3.micro \
 --subnet-id $PUBLIC_SUBNET_ID \
 --associate-public-ip-address \
 --key-name $KEY_NAME \
 --security-group-ids $SG_ID \
 --tag-specifications "ResourceType=instance,Tags=[{Key=CreatedBy,Value=$CREATED_BY}]" \
 --query 'Instances[0].InstanceId' \
 --output text \
 --region $REGION)

if [ -z "$INSTANCE_ID" ]; then
  echo "Erro: instância não foi criada."
  exit 1
fi

echo "Instância lançada: $INSTANCE_ID"

aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

PUBLIC_IP=$(aws ec2 describe-instances \
 --instance-ids $INSTANCE_ID \
 --query 'Reservations[0].Instances[0].PublicIpAddress' \
 --output text \
 --region $REGION)

echo "IP público da instância: $PUBLIC_IP"
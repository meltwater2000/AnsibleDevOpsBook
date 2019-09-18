# Usage: sh info-aws.sh <aws-instance-id>
aws ec2 describe-instances --instance-ids $1
aws ec2 describe-instances --instance-ids $1 \
  --query 'Reservations[*].Instances[*].{Instance:InstanceId:PublicDnsName}' \
  --output json
aws ec2 describe-instances --instance-ids $1 \
  --query 'Reservations[*].Instances[*].{Instance:InstanceId,State:Name}' \
  --output json

# Usage: sh info-aws.sh <aws-instance-id>
echo ==Everything
aws ec2 describe-instances --instance-ids $1
echo ==Instance Info
aws ec2 describe-instances --instance-ids $1 \
  --query 'Reservations[*].Instances[*].{Instance:InstanceId,Instance:NetworkInterfaces}' \
  --output json
echo ==Netowrk Info
aws ec2 describe-instances --instance-ids $1 \
  --query 'Reservations[*].Instances[*].NetworkInterfaces[*].{NetworkInterfaces:Association}' \
  --output json
echo ==Status
aws ec2 describe-instances --instance-ids $1 \
  --query 'Reservations[*].Instances[*].{Instance:State}' \
  --output json

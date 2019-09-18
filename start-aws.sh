# Usage: sh start-aws.sh <aws-instance-id>
aws ec2 start-instances --instance-ids $1

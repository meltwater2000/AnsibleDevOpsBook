# Usage: sh stop-aws.sh <aws-instance-id>
aws ec2 stop-instances --instance-ids $1

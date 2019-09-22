# Usage: sh connect.sh <aws-public-ip-address>
ssh -i ~/.aws/.ssh/awsbox.pem ec2-user@$1

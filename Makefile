BUCKET="YOUR_BUCKET"
PREFIX=""

KEY_NAME="YOUR_KEYPAIR"
VPC_ID="YOUR_VPC_ID"
SUBNET_ID="YOUR_SUBNET_ID"

.PHONY:
upload_cfn_template:
	@aws s3 cp ./ec2-softether.yaml s3://$(BUCKET)$(PREFIX)/

.PHONY:
deploy:
	@aws cloudformation create-stack \
		--stack-name softether \
		--template-url https://s3.amazonaws.com/$(BUCKET)$(PREFIX)/ec2-softether.yaml \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameters ParameterKey=KeyName,ParameterValue=$(KEY_NAME) \
		             ParameterKey=VpcId,ParameterValue=$(VPC_ID) \
					 ParameterKey=SubnetId,ParameterValue=$(SUBNET_ID)

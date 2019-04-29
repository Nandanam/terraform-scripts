#Automating Edcast Cloud Infrastructure using Terraform
> The repository consists of file to automate Edcast AWS   infrastructure using Terraform.
> The main objective of this project is to replicate the exsisting Edcast Cloud infrastructure and replace Elastic Beanstalk Servers with Elastic Kubernetes Service(EKS).
AWS services that will be built by this Script.
    > Virtual Private Cloud (VPC)
    > Elastic Compute Cloud (EC2)
    > Relational Database Service(RDS)
        > Mysql
        > Postgres
    > Elastic Kubernetes Service(EKS)
    > Cloud front
    > Redis Cluster
    > Memcache Cluster
    > CloudWatch 
    > Simple Notification Service(SNS)

# Following steps to run terraform script on PC

# Terraform dependency
#make sure version v0.11 and above
terraform version

# Execution
## Initializes Terraform and downloads dependencies required 
terraform init

## Plan gives the illustrated list of services and its configurations that are going to be deployed 
```
terraform plan
```
## Deploys infrastructure 
```
terraform  apply
```
# Output the files
```
terraform  output
```
# Install AWS CLI on local
Prerequisites
Python 2 version 2.6.5+ or Python 3 version 3.3+

Check your Python installation.
```
python --version
```
Install the AWS CLI on macOS Using pip
```
pip --version
pip install awscli
```
Verify that the AWS CLI is installed correctly.
```
aws --version
```
Configure AWS CLI(Add access-key and secret key)
```
aws configure
```

# Setting local system to access EKS cluster. Follow the below steps.
( The following commands are for the Mac OS) 

# Kubectl dependency
```
brew install kubernetes-cli
```
#make sure version greater 1.10 or above
```
kubectl version
```
#Follow the “caveats” section of brew’s output to add the appropriate bash completion path to your local .bashrc.

# Authenticator dependency
#install aws-iam-authenticator
```
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator
chmod +x aws-iam-authenticator
mv aws-iam-authenticator /usr/local/bin/heptio-authenticator-aws
heptio-authenticator-aws help
```

# kubctl for cluster
#copy kubectl config from output and place it in ~/.kube/config

# Config map configuration 
#copy config-auth-map from output into config_map_aws_auth.yaml
```
kubectl apply -f config_map_aws_auth.yaml
```

# Deploy pod in worker-node
# dashboard
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl get pods --all-namespaces
```

# Heapster
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
```

# Heapster-DB
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
```
# cluster role bind to dash-board
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
kubectl apply -f apps/eks-admin-service-account.yaml
kubectl apply -f apps/eks-admin-cluster-role-binding.yaml
```


# connect to Dashboard
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```

# kill any procee runs on 8001
```
lsof -ti:8001 | xargs kill -9
kubectl proxy
```

# Open the Dashboard
```
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```
#paste Token which is generated for login

# Cleanup infrastructure
```
terraform destroy
```

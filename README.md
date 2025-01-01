Steps for Infrastructure Deployment (CloudFormation)
bash
Copy code
aws cloudformation create-stack \
  --stack-name eks-infra-stack \
  --template-body file://eks_complete_infra.yml \
  --capabilities CAPABILITY_NAMED_IAM
This will create the infrastructure required for the project such as AWS EKS cluster, AWS S3 bucket, VPC, subnets, route table, internet gateway, and connect them together.

Steps for Container Deployment
Prerequisites (Commands Only)
Install AWS if not installed already (I had it installed on my local system, Ubuntu):

bash
Copy code
aws configure
Access Key From IAM Console

Secret Access Key From IAM Console

Update Kubernetes Config for EKS Cluster:

bash
Copy code
aws eks update-kubeconfig --region <your-region> --name <your-cluster-name>
Create ECR Repo Manually from AWS Console or CLI.

Install Helm if not already installed:

bash
Copy code
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
Create a Helm Chart to Deploy an NGINX Container on the EKS Cluster
Create a Helm chart for NGINX:

bash
Copy code
helm create nginx-helm  # Creates a Helm chart folder with default files
Move to the directory:

bash
Copy code
cd nginx-helm
Check for errors in the chart:

bash
Copy code
helm lint
Install NGINX using Helm:

bash
Copy code
helm install nginx-release ./nginx-helm
Note: values.yml, service.yaml, and deployment.yaml are already provided for Helm configuration. We do not need to change anything.

Verify the NGINX Pod is running:

bash
Copy code
kubectl get pods
Verify the EXTERNAL-IP for the LoadBalancer:

bash
Copy code
kubectl get svc
Expose the Service with a Kubernetes LoadBalancer
Open the following URL in your browser to see NGINX running:

arduino
Copy code
http://<EXTERNAL-IP>
Steps for CI/CD Pipeline (GitHub Actions)
Prerequisites
Must have the Dockerfile (very simple in this case for NGINX).

Make GitHub Secrets for the following variables so GitHub can securely interact with AWS:

AWS_ACCESS_KEY_ID
AWS_ACCOUNT_ID
AWS_REGION
AWS_SECRET_ACCESS_KEY
ECR_REPOSITORY_NAME
Create a GitHub repository locally in your root directory of the project.

Create the file .github/workflows/ci-cd.yml (already provided).

This file will:

Login to AWS using secrets stored in GitHub.
Build the image from the Dockerfile.
Push the image to AWS ECR.
Output
Whenever you push the code to GitHub, it will trigger the CI pipeline. The pipeline will:

Create the image from the Dockerfile.
Push the image to AWS ECR if the login is successful.

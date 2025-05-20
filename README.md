# Flask App on Azure Container Instance

This project demonstrates how to deploy a simple Flask application to Azure Container Instance (ACI) using Terraform.

## Project Structure

```
Azure-Devops/
├── app.py                # Flask application
├── requirements.txt      # Python dependencies
├── Dockerfile            # Container definition
├── main.tf               # Terraform main configuration
├── variables.tf          # Terraform variables
├── outputs.tf            # Terraform outputs
└── README.md             # This file
```

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads.html)
- [Docker](https://docs.docker.com/get-docker/)
- An Azure subscription

## Setup and Deployment

### 1. Log in to Azure

```bash
az login
```

### 2. Build the Docker image locally

```bash
docker build -t flask-app:latest .
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Apply Terraform configuration

```bash
terraform apply
```

### 5. Get the ACR login server

After Terraform has finished creating resources, it will output the ACR login server. Use this for the next steps:

```bash
export ACR_LOGIN_SERVER=$(terraform output -raw acr_login_server)
export ACR_USERNAME=$(terraform output -raw acr_admin_username)
export ACR_PASSWORD=$(az acr credential show -n $(terraform output -raw acr_admin_username) --query "passwords[0].value" -o tsv)
```

### 6. Tag the Docker image

```bash
docker tag flask-app:latest $ACR_LOGIN_SERVER/flask-app:latest
```

### 7. Log in to ACR

```bash
docker login $ACR_LOGIN_SERVER -u $ACR_USERNAME -p $ACR_PASSWORD
```

### 8. Push the Docker image to ACR

```bash
docker push $ACR_LOGIN_SERVER/flask-app:latest
```

### 9. Verify deployment

After the image is pushed, Terraform will deploy the container to ACI. You can access your application at:

```
http://<dns_name_label>.<azure_region>.azurecontainer.io:8080
```

The full URL is also provided in the Terraform output as `container_fqdn`.

## Cleanup

To remove all resources created by this project:

```bash
terraform destroy
```

## Notes

- The Azure Container Registry name must be globally unique
- The DNS name label for the container group must be unique within the Azure region
- The Flask app runs on port 8080 inside the container

# lilalou-infra
Lila Lou Infrastructure As Code

Owner: Lila Lou Designs

# Terraform Commands
## Multi env backend initialisation
### Dev
terraform init -reconfigure -backend-config=bucket=${TF_BUCKET_PREFIX}-dev -backend-config=profile=tf-lou-dev

### Prod
terraform init -reconfigure -backend-config=bucket=${TF_BUCKET_PREFIX}-prod -backend-config=profile=tf-lou-prod

## Terraform Plan
### Dev
terraform plan -var-file=env/dev.tfvars -out=dev.tfplan

### Prod
terraform plan -var-file=env/prod.tfvars -out=prod.tfplan

## Terraform Apply
### Dev
terraform apply dev.tfplan

### Prod
terraform apply prod.tfplan

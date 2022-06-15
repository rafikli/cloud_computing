# Cloud Computing
## EKS (Elastic Kubernetes Service
Criação automatizada de clusters e deployamento de aplicações auto escalaveis

### Para criar infraestrutura:

```bash
cd provision-eks-terraform/
terraform init
terraform plan
terraform apply --auto-approve
```
### Para criar aplicações:

```bash
cd manage-applications/
terraform init
terraform plan
terraform apply --auto-approve
```
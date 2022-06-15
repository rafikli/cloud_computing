# Terraform HSL script for proviosiong an eks cluster with 3 nodes

## To deploy the cluster do

### Export AWS credentials:
    
``` bash
    export AWS_ACCESS_KEY_ID=<your_access_key_id>
    export AWS_SECRET_ACCESS_KEY=<your_secret_access_key>
    export AWS_DEFAULT_REGION=<your_region>
```

### Run Terraform script:
``` bash
    terraform init
    terraform apply -auto-approve
```

### enable kubectl:

``` bash
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```
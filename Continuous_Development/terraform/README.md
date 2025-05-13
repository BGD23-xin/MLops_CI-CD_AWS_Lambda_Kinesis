# command

### installation of terraform
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

```
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```bash
sudo apt-get update && sudo apt-get install terraform

```

Attention: if you want to use a s3 bucket as a backup workflows, need to creat firstly a s3 bucket and then you can use it in your main.tf.
So in this project, i use the file in directory `backend` to create a backup folder

### plan and apply
there are two files of variables for two situations(production and test)
```bash
terraform plan -var-file="vars/prod.tfvars"
```
or

```bash
terraform plan -var-file="vars/stg.tfvars"
```

```bash
aws kinesis list-streams
```

```bash
aws kinesis get-records \
  --shard-iterator $(aws kinesis get-shard-iterator \
    --stream-name ride_predictions \
    --shard-id shardId-000000000000 \
    --shard-iterator-type TRIM_HORIZON \
    --region eu-west-3 \
    --query 'ShardIterator' \
    --output text) \
  --region eu-west-3
```

`ride_predictions` is the kinesis you want to test

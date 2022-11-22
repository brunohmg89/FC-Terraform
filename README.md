# Repositório criado para armazenar conteúdo do curso da FC sobre TerraForm

## Introdução

- Introdução ao terraform

## Conceitos básicos na prática

1. Tour pelo Terraform.io

- Navegando pelo site e as documentações do terraform

2. Instalando o terraform

- Instalando o terraform

3. Executando o terraform pela primeira vez

- Criando o primero recurso com provider `local`

4. Trabalhando com váriaveis

- Criando o arquivo `terraform.tfvars`

5. Outputs

- Setando um output dentro do arquivo `local.tf`

6. Data Sources

- Usando data para utilizar o arquivo criado

## Criando cluster Kubernetes

1. Repositório

- Manifesto da FC <https://github.com/codeedu/fc2-terraform>

2. Conceitos de VPC na AWS

- Foi mostrado os conceitos de VPC dentro da AWS

3. Entendendo conceitos no console da AWS

- Mostrou a console da AWS, zones e regions

- Detalhes das VPC e seus atributos

- Mostrando calculo de subnets

4. Criando user admin na AWS

- Na AWS existe a conta `root`, recomenda-se que criemos uma conta de administração

- Criando uma conta de administração com a permissão `administratoraccess`

- Credenciais setadas dentro do arquivo `credenciais.txt`

5. Configurando AWS CLI

- Ajuda para a configuração da linha de comando da AWS

6. Criando VPC

- Criando VPC pelo terradorm pelo bloco `resource "aws_vpc"` dentro do arquivo `vpc.tf`

7. Criando subnets

- Criando subnets pelo terraform pelo bloco `resource "aws_subnet"` dentro do arquivo `vpc.tf`

8. Refatorando subnets

- Criando e utilizando o arquivo `terraform.tfvars` e usando váriavel

- Refatorando o bloco `resource "aws_vpc"` setando `prefix`

- Refatorando o bloco `resource "aws_subnet"` setando um count para o nome da subnet e para o range de IP.

9. Internet Gateway e Route Table

- Criando Internet Gateway com o bloco `resource "aws_internet_gateway"`

- Criando o Route Table com o bloco `resource "aws_route_table"`

10. Criando Security Group

- Criando o arquivo `cluster.tf`

- Criando o security group com o bloco `resource "aws_security_group"`

11. Criando role e policies

- Criando a role com o bloco `resource "aws_iam_role"`

- Criando as policies da role com o bloco `resource "aws_iam_role_policy_attachment"`

12. Cluster EKS no ar

- Gerando logs do Kubernetes com o bloco `resource "aws_cloudwatch_log_group"`

- Criando o cluster kubernetes com o bloco `resource "aws_eks_cluster"`

13. Criando Workers para o Cluster

- Criando o arquivo `nodes.tf`

- Criando roles para o node com o bloco `resource "aws_iam_role"`

- Criando policies para role do node com o bloco `resource "aws_iam_role_policy_attachment"`

- Criando nodes com o bloco `resource "aws_eks_node_group"`

14. Criando mais um node group

-



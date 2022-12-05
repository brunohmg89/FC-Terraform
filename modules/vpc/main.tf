##################
# Criação de VPC #
##################

resource "aws_vpc" "new-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

#####################
# Verificação de AZ #
#####################

data "aws_availability_zones" "teste" {}

#########################################
# Refatoracao e utilizacao de variaveis #
#########################################

resource "aws_subnet" "subnets" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.teste.names[count.index]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet${count.index}"
  }
}

###############################
# Criação do Internet Gateway #
###############################

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.new-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

##########################
# Criação de Route Table #
##########################

resource "aws_route_table" "my-rtb" {
  vpc_id = aws_vpc.new-vpc.id
  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}

#######################################
# Associando endereços ao route table #
#######################################

resource "aws_route_table_association" "my-rtb-association" {
  count          = 2
  route_table_id = aws_route_table.my-rtb.id
  subnet_id      = aws_subnet.subnets.*.id[count.index]
}

#########################################
#   Criacao de subnets sem variaveis    #
#########################################

/*resource "aws_subnet" "my-subnet1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.new-vpc.id
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "${var.prefix}-subnet1"
  }
}

resource "aws_subnet" "my-subnet2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.new-vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "${var.prefix}-subnet2"
  }
}*/
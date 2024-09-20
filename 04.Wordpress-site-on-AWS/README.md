# Capstone Project 4: WordPress Site on AWS

## Project Scenario
My task as an AWS Solutions Architect is to design and implement a WordPress solution using various AWS services, such as Networking, Compute, Object Storage, and Databases for a small to medium-sized digital marketing agency, `Digitalboost`, to help enhance its online presence by creating a high-performance __WordPress-based webiste__ for their clients.

This agency needs a scalable, secure, and cost-effective solutions that can handle increasing traffic and seamlessly integrate with their existing infrastructure.

## Project Components
1. VPC Setup
2. Public and Private Subnet with NAT Gateway
3. Security Groups & Instances Setup
3. AWS MySQL RDS Setup
4. EFS Setup for WordPress Files
5. Application Load Balancer and Auto Scaling

## STEP BY STEP PROCESS OF THE PROJECT
This is the Project Overview
![](./images/1.project%20overview.png)

## Step 1: VPC Setup
VPC Architecture
![](./images/2.VPC%20Setup.png)

* Create a Virtual Private Cloud (VPC) named `digitalboost-dev-vpc` with a defines IP Address range, to isolate and secure the WordPress infrastructure. 
![](./images/3.vpc%20created.png)

* Create Internet Gateway `dev-digitalboost-igw` to allow communication between instances in the VPC and the internet.
![](./images/4.create%20igw.png)

Attach Igw to VPC:

![](./images/5.action%20to%20attach%20to%20a%20vpc.png)
![](./images/6.select%20vpc%20to%20attach.png)

* Created `2 Public` and `4 Private` Subnets across two different Availability Zones for redundancy.

`Public Subnet` setup is for resources accessible from the internet.

`Private Subnet` Setup is for resoiurces with no direct internet access.

I used `2 Availability Zones` for high availability and fault tolerance.

1st Subnet:
![](./images/7.subnet1.png)

All 6 Subnets created

![](./images/13.%20subnets%20created.png)

* Configured Route Tables. I created 2 Route tables, `digitalboost-public-routetable` and `digitalboost-main-routetable`
![](./images/14%20create%20public%20routetable.png)
![](./images/15.%20create%20main%20routetable.png)

The public subnets were associated to the `digitalboost-public-routetable`.
![](./images/17.%20select%20%202%20public%20subnets.png)

Route the traffic to the IGW
![](./images/19.%20select%20internet%20gateway%20in%20route.png)

## Step 2: Public and Private Subnet with NAT Gateway.

### NAT Gateway Architecture
![](./images/20.%20NAT%20gateway.png)

* I created a NAT Gateway `digital-boost-ngw` for private subnet internet access.

Choose the public subnet for the NAT Gateway & Allocate an Elastic IP and create the NAT Gateway.
![](./images/21.%20create%20NATgateway%20in%20public%20subnet%20and%20click%20on%20allocate%20elastic%20IP.png)


* Next, The private subnets were associated with the `digitalboost-main-routetable`
![](./images/23.%20private%20subnets%20associated.png)

Route the traffic to the NGW 
![](./images/24.%20edit%20route.png)

* VPC Map Structure
![](./images/25.VPC%20Map%20Structure.png)


## Step 3: Security Groups & Instances Setup
### SECURITY GROUP ARCHITECTURE
![](./images/Security%20group.png)
* Created 5 security groups for all connections and edited inbound rules for them all.

__APPLICATION LOAD BALANCER (ALB) SECURITY GROUP.__
Created `digitalboost-ALB-security-grp` and ensured it had access to Port `80 and 443`. With Source: `0.0.0.0/0`
![](./images/26.ALB%20security%20group.png)

__SSH Security Group__
Created `digitalboost-SSH-security-grp` and ensured it had access to Port `22`. With Source: `My IP Address`
![](./images/27.%20SSH%20security%20grp.png)
![](./images/28.made%20source%20MyIP.png)

__WEBSERVER SECURITY GROUP__
Created `digitalboost-webserver-security-grp` and ensured it had access to Port `80 and 443` & `22`. With Source: `ALB Security Group` and `SSH Security Group`
![](./images/29.%20webserver%20security%20group.png)

__DATABASE SECURITY GROUP__
Created `digitalboost-database-security-grp` and ensured it had access to Port `3306`. With Source: `Webserver Security Group`
![](./images/30.%20database%20security%20grp.png)

__EFS Security Group__
Created `digitalboost-EFS-security-grp` and ensured it had access to Port `2049` and `22`. With Source: `Webserver Security Group` and `SSH Security Group`
![](./images/31.%20EFS%20Security%20grp.png)


## * __Bastion Host Instance Setup (Jump Server)__
To set up a secure access point for SSH into private EC2 instances, We need to create a Bastion Host Instance first. This bastion host is needed and will be placed in a public subnet.
 * Creating `digitalboost-bastion-host` instance. Create a Security Group for the Bastion Host allowing inbound SSH (port 22) from your IP address.
Launch the Bastion Host in a public subnet using Amazon Linux 2 AMI.
![](./images/32.%20create%20bastion%20instance.png)
![](./images/33.%20advanced%20settings.png)
![](./images/35.%20Bastion-host%20instance%20created.png)

* Connect to the instance using SSH.
```bash
ssh -i "bastion-host.pem" ec2-user@18.218.55.55
```

![](./images/36.%20to%20connect%20to%20instance.png)
* Successfully connected into the bastion host instance
![](./images/37.ssh%20into%20instance.png)




## Step 4: AWS MySQL RDS Setup
Deploy a managed MySQL database using Amazon RDS for WordPress data storage.
Steps:
Create an Amazon RDS instance `digitalboost-rds`,  With MySQL engine allowing inbound traffic on MySQL port 3306 from the WordPress EC2 instances.
![](./images/38.%20open%20RDS%20to%20create%20database.png)
![](./images/39.%20selecting%20MY%20SQL.png)

Launch the MySQL RDS Instance with appropriate configuration, such as storage and instance class.
![](./images/40%20engine%20version%20&%20free-tier.png)
![](./images/41.%20select%20self%20managed%20and%20password.png)
![](./images/42.%20choose%20VPC%20and%20make%20public.png)

* Under Connectivity, choose Public access and RDS Security Group created earlier.
![](./images/42.%20choose%20VPC%20and%20make%20public.png)
![](./images/43.%20select%20database%20security%20grp%20&%20availability%20zone.png)

`digitalboost-rds` created with status available.
![](./images/44.%20database%20created%20with%20available%20status.png)

* Copy endpoint details and save it in your notes.
![](./images/45.%20copy%20endpoint%20details%20and%20save.png)

### * __WordPress EC2 Instance Setup__
Deploy WordPress on a private EC2 instance. 
Created an instance for WordPress `digitalboost-webserver-instance` allowing SSH, HTTP, and HTTPS access.
Launch the EC2 Instance for WordPress in the private subnet with the necessary security group.
![](./images/46.%20webserver%20instance.png)
![](./images/47.%20select%20webserver%20SG.png)

`digitalboost-webserver-instance` created and running
![](./images/48.launched%20webserver%20instance.png)


* To connect to the webserver instance using SSH. I had to ssh into the bastion host instance I created earlier.
```bash
ssh -i "bastion-host.pem" ec2-user@18.218.55.55
```
![](./images/49.ssh%20into%20bastion-host.pem.png)

* Copied the `private key` from the `.pem` file downloaded in the local storage. 
```bash
cat bastion-host.pem
```
![](./images/52.copy%20private%20key%20using%20cat.png)

* Created a file `newfile` and pasted the private-key copied into the folder.
![](./images/50.create%20newfile%20and%20give%20permissions.png)

* With this `newfile` created, we can now ssh into the Webserver instance.

```bash 
ssh -i newfile ec2-user@10.0.2.125
```
![](./images/51.ssh%20into%20private%20subnet.png)

__Installing Apache, MySQL, and PHP on the Webserver EC2 instance.__

__Install WordPress and configure it to connect to the database__
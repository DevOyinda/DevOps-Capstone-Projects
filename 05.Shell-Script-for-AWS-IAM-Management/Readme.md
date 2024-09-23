# PROJECT 5: Shell Script for AWS IAM Management.

## Project Scenario
I have been assigned to create a shell script for Datawise Solutions, a company that needs efficient management of AWS Identity and Access Management (IAM) resources. As the company expands its team, they need to securely onboard five new employees with access to AWS resources.


## Project Objectives
1. Script Enhancement.
2. Define IAM User Names Array.
3. Create IAM Users.
4. Create IAM group.
5. Attach Administrative Policy to Group.
6. Assign Users to Group.

# LET'S DIVE INTO THE STEPS OF THE PROJECT

## Writing the Shell Script
### Step 1: Created a .sh file, edited it and gave the file execute permission.
`aws_cloud_manager.sh`

```bash
touch aws_cloud_manager.sh
vi aws_cloud_manager.sh
chmod +x aws_cloud_manager.sh
```

![](./img/2.create%20a%20.sh%20file%20&%20gave%20permissions.png)

### Step 2: Check if AWS CLI is installed.
```bash
if ! command -v aws &> /dev/null
then
    echo"AWS CLI could not be found. Please install it first."
    exit 1
fi
```

![](./img/3.check%20if%20AWS%20CLI%20is%20installed.png)

### Step 3: Define IAM User Names Array
Store the names of the five IAM users in an array for easy iteration during user creation.
```bash 
users=("employee1" "employee2" "employee3" "employee4" "employee5")
```

![](./img/4.create%20array%20for%205%20IAM%20users.png)

### Step 4: Create IAM Group
Define a function to create an IAM group named "admin" using the AWS CLI.
```bash
create_admin_group(){
    echo "Creating IAM group 'admin' ..."
    if aws iam create-group --group-name admin; then
        echo "IAM group 'admin' created."
    else 
        echo "Failed to create IAM group 'admin'. It may already exist."
    fi
}

```
![](./img/5.function%20to%20create%20IAM%20admin.png)

### Step 5: Attach Administrative Policy to Group
Attach an AWS-managed administrative policy(e.g. AdministratorAccess) to the "admin" group to grant administrative priviledges.
```bash
echo "Attaching the "AdministratorAccess' policy attached to the 'admin' group..."
if aws iam attach-group-policy --group-name admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess; then 
    echo "'AdministratorAccess' policy attached to the 'admin' group."
else 
    echo "Failed to attach 'AdministratorAccess' policy to 'admin' group."
fi

```
![](./img/6.attaching%20adminaccess%20policy%20to%20admin%20group.png)

### Step 6: Create IAM Users 
Iterate through the IAM user names array and create IAM users for each employee using AWS CLI commands.
```bash
for user in "${users[@]}"; do

# check if IAM user already exists
if aws iam get-user --user-name "$user" &>/dev/null; then
        echo "IAM user '$user' already exists."
else
        # Create IAM user
        echo "Creating IAM user '$user'..."
        if aws iam create-user --user-name "$user"; then
                echo "IAM ser '$user' created."
        else 
                #If error exists
                echo "Failed to create IAM user '$user'. Exiting."
                exit 1
        fi
fi
```

![](./img/7.create%20IAM%20users.png)

### Step 7: Attaching IAM Users to Admin Group.
Iterate through the array of IAM user names and assign each user to the "admin" group using AWS CLI commands.
```bash
echo "Adding IAM user '$user' to the 'admin' group..."
if aws iam add-user-to-group --user-name "$user" --group-name admin; then
        echo "IAM user '$user' added to the 'admin' group."
else 
        echo "Failed to add IAM user '$user' to the 'admin' group."
fi
```

![](./img/8.add%20IAM%20users%20to%20admin%20group.png)

### Step 8: Function Call
This is added later in the script to invoke or call the functions declared. It tells the script to execute the code defined within that function.
```bash
create_admin_group
onboard_users
```

![](./img/9.%20execute%20functions%20created.png)

### Step 9: At the end of the shell script. 
```bash
echo "All users have been onboarded and assigned to the 'admin' group with administrative priviledges."
```

![](./img/10.all%20users%20created%20and%20added.png)

## Linking the Script created for remote execution
1. Created, launched and connected to an Ec2 instance named `Datawise solutions instance`

![](./img/11.%20launch%20datawise%20instance.png)
![](./img/12.connect%20to%20instance.png)

2. Installed and setup apache server.
```bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
```

![](./img/13.install%20httpd%20into%20instance.png)
![](./img/14.%20enable&start%20httpd.png)

3. Next is to create ACCESS KEY on AWS IAM.
* I created an IAM user with and access key and applied priviledges permissions to that user.

 ![](./img/15.to%20create%20access%20key.png)

* Ensure the Command line Interface (CLI) is selected as the use case, as I plan to use this access key to enable AWS CLI to access my AWS account.

 ![](./img/16.select%20command%20line%20as%20use%20case.png)

* Once `Access key` and `Secret key` are created, ensure the `.csv file` is downloaded to save the details.

![](./img/17.download%20the%20access%20key%20&%20secret%20key%20and%20save%20details.png)

4. Create Policies and permissions.
In AWS, policies are used to manage and control access to AWS resources. They define permissions and specify what each user can perform specific actions.
* Created a policy named `IAM-access-policy` to give administrative access.

![](./img/20.give%20policy%20name%20&create.png)

* Policy permissions statements were modified using policy editor in `json` to have IAM services allowed.

![](./img/19.policy%20for%20administrative%20access.png)

* Attach policies created to the user.

![](./img/21.attach%20permission%20to%20user.%20select%20policy%20created.png)
![](./img/22.%20policy%20attached%20and%20customer%20managed.png)

5. Setting Up AWS CLI
* Used the command to set up CLI and configured the access key to the apache server.
```bash
aws configure
```
After running this command, it will ask to provide the following details
`AWS Access Key ID`
`AWS Secret Access Key`
`Default Region Name`
`Default Output Format`

![](./img/24.%20aws%20configure%20and%20fill%20with%20users%20details.png)

6. Created the shell script file `aws_cloud_manager`, edited it with `vim` and gave the file execute permissions.
```bash
touch aws_cloud_manager.sh
vi aws_cloud_manager.sh
chmod +x aws_cloud_manager.sh
```

![](./img/23.%20create%20.sh%20and%20type%20script%20in%20it.png)
![](./img/file%20code.png)

* To run the shell script
```bash
./aws_cloud_manager.sh
```

![](./img/run%20the%20code.png)

7. Scripts running
* creating IAM admin group on AWS CLI

![](./img/25.creating%20IAM%20group%20admin.png)

* Attaching admin access to admin group

![](./img/26.attaching%20adminacces%20policy%20to%20admin.png)

* Creating all 5 employees(users) and adding to admin group. 
For employee1
![](./img/26.%20create%20employee1mand%20attaching%20to%20admin%20group..png)
Creating for 4 other employees

![](./img/27.%20creating%202,3,4,5%20employee.png)

## Verifying the Creation of users, groups, and admin access policy on the AWS IAM resource.
1. To verify admin group was created. 
Open IAM on AWS and go to groups. The admin group name should appear as the user group created.

![](./img/28.confirm%20user%20group%20created.png)

2. To verify all the users were created and are in the admin group.

![](./img/29.confirm%20all%20users%20in%20the%20group.png)

3. To confirm, the admin group has Administratoraccess.

![](./img/30admin%20group%20has%20AdministratorAccess.png)


## WITH THIS PROJECT I WAS ABLE TO HELP DATAWISE SOLUTIONS COMPANY EXPAND ITS TEAM AND ALLOW ACCES TO AWS RESOURCES SECURELY USING SHELL SCRIPTING




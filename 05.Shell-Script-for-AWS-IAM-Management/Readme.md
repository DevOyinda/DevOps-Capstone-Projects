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
### Step 1: Created a .sh file and gave the file execute permission.
`aws_cloud_manager.sh`

```bash
touch aws_cloud_manager.sh
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
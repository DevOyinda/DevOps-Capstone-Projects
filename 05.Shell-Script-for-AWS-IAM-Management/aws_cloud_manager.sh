#!/bin/bash

# This script onboards 5 employees by creating IAM users, an admin group,
# and assigns administrative privileges to the users and ensures the AWS CLI is installed

if ! command -v aws &> /dev/null
then
	echo "AWS CLI could not be found. Please install it first."
	exit 1
fi


# Array of IAM user names (for the 5 employees)
users=("employee1" "employee2" "employee3" "employee4" "employee5")

# Function to create an IAM group named 'admin'
create_admin_group() {
    echo "Creating IAM group 'admin'..."
    if aws iam create-group --group-name admin; then
	    echo "IAM group 'admin' created."
    else
	    echo "Failed to create IAM group 'admin'. It may already exist."
    fi


    # Attach the AWS managed policy for admin privileges to the 'admin' group
    echo "Attaching the 'AdministratorAccess' policy to the 'admin' group..."
    if aws iam attach-group-policy --group-name admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess; then
	    echo "'AdministratorAccess' policy attached to the 'admin' group."
    else
	    echo "Failed to attach 'AdministratorAccess' policy to 'admin' group."
    fi
}


# Function to create IAM users and add them to the 'admin' group
onboard_users() {
    for user in "${users[@]}"; do

	# check if IAM user already exists
	if aws iam get-user --user-name "$user" &>/dev/null; then
	    	echo "IAM user '$user' already exists."
	else
		# Create IAM user
        	echo "Creating IAM user '$user'..."
        	if aws iam create-user --user-name "$user"; then
        		echo "IAM user '$user' created."
		else 
			#If error exists
    			echo "Failed to create IAM user '$user'. Exiting."
			exit 1
		fi
	fi

	
	# Add IAM user to the 'admin' group
        echo "Adding IAM user '$user' to the 'admin' group..."
        if aws iam add-user-to-group --user-name "$user" --group-name admin; then
        	echo "IAM user '$user' added to the 'admin' group."
	else 
		echo "Failed to add IAM user '$user' to the 'admin' group."
	fi
done
}


# Create the admin group and attach the administrative policy
create_admin_group

# Onboard the users and assign them to the admin group
onboard_users

echo "All users have been onboarded and assigned to the 'admin' group with administrative privileges."

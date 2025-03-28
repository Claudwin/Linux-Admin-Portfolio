#!/bin/bash

# Script to create users with specific permissions
# Created for RHCSA study - Day 3

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Create groups if they don't exist
echo "Creating groups..."
groupadd -f developers
groupadd -f admins
groupadd -f analysts
echo "Gruops created successfully"

# Function to create a user
create_user() {
    local username=$1
    local primary_group=$2
    local secondary_groups=$3
    local password=$4
    local shell=$5
    local expiry_days=$6

    # Create user
    useradd -m -g $primary_group -G $secondary_groups -s $shell $username

    # Set password
    echo "$username:$password" | chpasswd

    # Set password expiry if specified
    if [! -z "$expiry_days "]; then
        chage -M $expiry_days $username
    fi  

    echo " User $username created successfully."
}

# Create project directory strcuture
echo "Creating project directories..."
mkdir -p /projects/{public,restricted,confidential}

# Set base permissions
chmod 755 /projects/public
chmod 750 /projects/restricted
chmod 700 /projects/confidential

# Create sample files
echo "Sample public file" > /projects/public/info.txt
echo "Sample restricted file" > /projects/restricted/data.txt
echo "Sample confidential file" > /projects/confidential/secret.txt

# Set file permission
chmod 644 /projects/public/info.txt
chmod 640 /projects/restricted/data.txt
chmod 600 /projects/confidential/secret.txt

# Crceate users with specific configurations
echo "Creating users"
create_user "dev1" "developers" "analysts" "password123" "/bin/bash" "90"
create_user "dev2" "developers" "" "password123" "/bin/bash" "90"
create_user "admin1" "admins" "developers" "password123" "/bin/bash" ""
create_user "analyst1" "analysts" "" "password123" "/bin/bash" "60"

# Set ownership for directories
chown root:developers /projects/public
chown root:admins /projects/restricted
chown root:admins /projects/confidential

# Apply SELinux context if SELinux is enabled

if ["($getenforce)" != "Disabled"]; then
    echo "Setting SELinux context..."
     semanage fcontext -a -t public_content_t "/projects/public(/.*)?"
    semanage fcontext -a -t public_content_rw_t "/projects/restricted(/.*)?"
    semanage fcontext -a -t admin_home_t "/projects/confidential(/.*)?"
    restorecon -R /projects
    echo "SELinux contexts applied."
fi

echo "Setup completed successfully!"



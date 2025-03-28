# User Creation Script Explanation

This script automates the creation of users with specific permissions, groups, and file access. Below is a line-by-line explanation of what the script does.

## Script Overview

This bash script:
1. Creates three user groups
2. Sets up a project directory structure with varying permission levels
3. Creates four users with different group memberships and settings
4. Configures file permissions and ownership
5. Applies SELinux contexts if SELinux is enabled

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

id -u: Gets the user ID of the current user
-ne 0: Checks if the ID is not equal to 0 (root's ID is always 0)
If the user isn't root, it displays an error message and exits with code 1

# Create groups if they don't exist
echo "Creating groups..."
groupadd -f developers
groupadd -f admins
groupadd -f analysts
echo "Groups created successfully."

groupadd: Command to create a new group
-f: Force option, which means if the group already exists, don't treat it as an error
This creates three groups: developers, admins, and analysts

# Function to create a user
create_user() {
    local username=$1
    local primary_group=$2
    local secondary_groups=$3
    local password=$4
    local shell=$5
    local expiry_days=$6

This defines a function called create_user that accepts 6 parameters
local defines variables that only exist within this function
$1, $2, etc. are the parameters passed to the function

# Create user 
    useradd -m -g $primary_group -G $secondary_groups -s $shell $username

useradd: Command to create a new user
-m: Create the user's home directory
-g $primary_group: Set the primary group for the user
-G $secondary_groups: Set additional (secondary) groups for the user
-s $shell: Specify the user's login shell : $username: The name for the new user

# Set password
    echo "$username:$password" | chpasswd

echo "$username:$password": Outputs the username and password separated by a colon
|: Pipe symbol, sends the output of the echo command to the next command
chpasswd: Takes the username format and sets the password for the user

 # Set password expiry if specified
    if [ ! -z "$expiry_days" ]; then
        chage -M $expiry_days $username
    fi

[ ! -z "$expiry_days" ]: Checks if the expiry_days variable is not empty
chage: Command to change user password expiry information
-M $expiry_days: Set the maximum number of days until the password must be changed
- $username: The user to apply this setting to

# Create project directory structure
echo "Creating project directories..."
mkdir -p /projects/{public,restricted,confidential}

mkdir: Command to create directories
-p: Create parent directories if they don't exist
/projects/{public,restricted,confidential}: Creates three directories at once using brace expansion

# Set base permissions
chmod 755 /projects/public
chmod 750 /projects/restricted
chmod 700 /projects/confidential

chmod: Command to change file/directory permissions
755: Numeric permission (rwxr-xr-x) - Owner can read/write/execute, Group and Others can read/execute
750: Numeric permission (rwxr-x---) - Owner can read/write/execute, Group can read/execute, Others have no permissions
700: Numeric permission (rwx------) - Owner can read/write/execute, Group and Others have no permissions

# Create sample files
echo "Sample public file" > /projects/public/info.txt
echo "Sample restricted file" > /projects/restricted/data.txt
echo "Sample confidential file" > /projects/confidential/secret.txt

echo: Outputs the text
>: Redirects the output to a file (creates the file if it doesn't exist)
This creates three sample files with different content

# Set file permissions
chmod 644 /projects/public/info.txt
chmod 640 /projects/restricted/data.txt
chmod 600 /projects/confidential/secret.txt

644: Numeric permission (rw-r--r--) - Owner can read/write, Group and Others can only read
640: Numeric permission (rw-r-----) - Owner can read/write, Group can read, Others have no permissions
600: Numeric permission (rw-------) - Owner can read/write, Group and Others have no permissions

# Create users with specific configurations
echo "Creating users..."
create_user "dev1" "developers" "analysts" "password123" "/bin/bash" "90"
create_user "dev2" "developers" "" "password123" "/bin/bash" "90"
create_user "admin1" "admins" "developers" "password123" "/bin/bash" ""
create_user "analyst1" "analysts" "" "password123" "/bin/bash" "60"

This calls the create_user function we defined earlier for each of the four users
For each user, it specifies:

Username (e.g., "dev1")
Primary group (e.g., "developers")
Secondary groups (e.g., "analysts" or none when "")
Password (e.g., "password123")
Login shell (e.g., "/bin/bash")
Password expiry in days (e.g., "90" days or none when "")



# Set ownership for directories
chown root:developers /projects/public
chown root:admins /projects/restricted
chown root:admins /projects/confidential

chown: Command to change file/directory owner and group
root:developers: Set owner to root and group to developers
This sets the ownership of each directory to root (owner) and the appropriate group

# Apply SELinux contexts if SELinux is enabled
if [ "$(getenforce)" != "Disabled" ]; then

getenforce: Command to check if SELinux is enabled
This condition only executes the following commands if SELinux is not disabled

   echo "Setting SELinux contexts..."
    semanage fcontext -a -t public_content_t "/projects/public(/.*)?"

semanage fcontext: Command to manage SELinux file context
-a: Add a new context
-t public_content_t: Specify the type as public_content_t
"/projects/public(/.*)?": Apply to the /projects/public directory and everything under it

   restorecon -R /projects

restorecon: Restore the default SELinux contexts
-R: Apply recursively
/projects: The directory to apply to

echo "Setup completed successfully!"

Prints a success message when the script completes


This detailed explanation breaks down each command used in the script, what the options mean, and what each section accomplishes. This should help you understand how the script works as you learn Linux commands and concepts.
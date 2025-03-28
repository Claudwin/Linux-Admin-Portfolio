# Linux File Permissions and SELinux Basics

## Standard File Permissions

In Linux, file permissions control who can read, write, or execute files and directories. The permissions are divided into three categories:

- **Owner**: The user who owns the file
- **Group**: The group associated with the file
- **Others**: Everyone else

Each category can have the following permissions:
- **r (read)**: View the contents
- **w (write)**: Modify the contents
- **x (execute)**: Execute the file or access the directory

### Commands for Managing Permissions

#### Viewing Permissions

-rw-r--r-- 1 user1 developers 20 Mar 28 10:15 public_doc.txt

In this example above:
-rw-r--r--: Permissions(ownder: read/write, groupd: read, others: read)
user1: Owner
developers: Group
20: file size in bytes

#### Changing Permissions with chmod numeric notations

644 permissions (rw-r--r--) to public file
Owner: read,write
Group: read
Others: read

640 permissions (rw-r-----) to restricted file
Owner: read,write
Group: read
Others: no access

600 permissions (rw-------) to confidential file
Owner: read,write
Group: no access
Others: no access

### SELinux Basics
SELinux (Security-Enhanced Linux) adds an additional layer of security beyond standard file permissions. It implements mandatory access controls through security contexts.

### Checking SELinux Status

getenforce - The getenforce command in Linux reports whether SELinux is currently in Enforcing, Permissive, or Disabled mode


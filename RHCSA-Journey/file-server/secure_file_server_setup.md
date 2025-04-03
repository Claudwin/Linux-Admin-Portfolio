# Secure Linux File Server - Day 1

## Directory Structure Setup

I created the following directory structure for the file server:
- `/srv/fileserver/public` - Accessible to all users
- `/srv/fileserver/team` - Accessible to team members (developers)
- `/srv/fileserver/secure` - Accessible to analysts and administrators

#### Commands used:
*```bash
```sudo mkdir -p /srv/fileserver/{public,team,secure}```

## User and Group Management

- developers - For development team members
- analysts - for data analysts
- interns - For temporary staff

#### Commands used:
*```bash

sudo groupadd developers
sudo groupadd analysts
sudo groupadd interns

* Create users and assign to appropriate groups
```sudo useradd -m -G developers dev1```
```sudo useradd -m -G developers dev2```
```sudo useradd -m -G analysts analyst1```
```sudo useradd -m -G interns intern1```

* Create admin user and add to all groups
sudo useradd -m admin1
sudo usermod -aG developers,analysts,interns admin1

* Set passwords for all users
echo "Setting passwords for all users..."
for user in dev1 dev2 analyst1 intern1 admin1; do
  sudo passwd $user
done

* Verify user creation and group membership
```for user in dev1 dev2 analyst1 intern1 admin1; do```
 ``` id $user```
```done```

## Permission Configurations
- Owner Permissions
- Group Permissions
- Other Permissions

#### Commands used:
*```bash

* Set base permissions on directories
```sudo chmod 775 /srv/fileserver/public```
```sudo chmod 770 /srv/fileserver/team```
```sudo chmod 770 /srv/fileserver/secure```

* Set group ownership
```sudo chgrp developers /srv/fileserver/public```
```sudo chgrp developers /srv/fileserver/team```
```sudo chgrp analysts /srv/fileserver/secure```

* Create sample files
```echo "Welcome to the public file share!" | sudo tee /srv/fileserver/public/welcome.txt```
```echo "Team meeting notes for developers" | sudo tee /srv/fileserver/team/team_notes.txt```
```echo "Confidential analyst report" | sudo tee /srv/fileserver/secure/confidential.txt```

* Set file permissions
````sudo chmod 664 /srv/fileserver/public/welcome.txt```
```sudo chmod 660 /srv/fileserver/team/team_notes.txt```
```sudo chmod 660 /srv/fileserver/secure/confidential.txt```

* Change owner of confidential file to admin1
```sudo chown admin1:analysts /srv/fileserver/secure/confidential.txt```

## Testing 

- Ensure permissions are working

```sudo -u $user ls -la /srv/fileserver/public/```














Commands used:


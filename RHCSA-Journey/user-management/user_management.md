# Linux User and Group Management

## User Creation and Management

In this lab exercise, I created 5 users with different configurations and permissions:

## 1. Basic User Creation

Options used:
sudo useradd 
sudo passwd 

The useradd command creates a new user account. By default, it creates the user with minimal settings.

## 2. Basic Group Creation & Management

Options used:
sudo groupadd -> Create groups
sudo usermod -g -> Add users to primary groups
sudo usermod -aG -> Add users to supplementary groups

## 3. Password Policies

##### Set password expiry for user1 (password expires in 30 days)
sudo chage -M 30 user1

#### Set password expiry for user2 (password expires in 90 days)
sudo chage -M 90 user2

#### Set minimum days between password changes for user3
sudo chage -m 7 user3

#### Set account inactivity limit for user4
sudo chage -I 30 user4

#### Check current password settings for a user
sudo chage -l user1

## 4. Account Expiration and Locking
#### Lock user1's account
sudo usermod -L user1

#### Set user3's account to expire on a certain date
sudo usermod -e 2025-04-30 user3

#### Unlock user1's account
sudo usermod -U user1

#### Check if user is locked by viewing /etc/shadow
sudo grep user1 /etc/shadow
#### If there's an ! before the password hash, the account is locked
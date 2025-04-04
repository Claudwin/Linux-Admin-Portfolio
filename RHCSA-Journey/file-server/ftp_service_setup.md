# Secure File Server - FTP Service Setup

## Installing and Configuring vsftpd

Today I set up the FTP service for the secure file server using vsftpd (Very Secure FTP Daemon).

### Installation Process

I installed the vsftpd package using:

```sudo dnf install -y vsftpd```

### Configuration Changes

| Setting | Value | Purpose |
|---------|-------|---------|
| local_enable | YES | Allows local system users to log in |
| write_enable | YES | Allows users to upload files |
| local_umask | 022 | Sets permissions for new files (644) |
| chroot_local_user | YES | Restricts users to their home directories |
| allow_writeable_chroot | YES | Allows users to write to their home directories |
| xferlog_enable | YES | Enables logging of transfers |
| xferlog_file | /var/log/vsftpd.log | Location for log files |
| ftpd_banner | Welcome message | Sets a greeting for users |

### Symbolic Links for User Access

* I created symbolic links in each user's home directory to provide appropriate access:

* Developers (dev1, dev2):```public``` ```team```

* Interns (intern1): ```public``` 

* Analysts (analyst1): ```public``` ```secure```

* Admin (admin1): ```All directories```

### Service Management

I started and enabled the service with:

```sudo systemctl start vsftpd``` </br>
```sudo systemctl enable vsftpd```

### Firewall Configuration

I configured the firewall to allow FTP traffic:

```sudo firewall-cmd --permanent --add-service=ftp```
```sudo firewall-cmd --reload```

### Testing FTP Access
I tested FTP access for the following users:

dev1 (Developer)
Result: Successfully accessed public and team directories
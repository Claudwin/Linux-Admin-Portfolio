# Secure Linux File Server - Day 1

## Directory Structure Setup

I created the following directory structure for the file server:
- `/srv/fileserver/public` - Accessible to all users
- `/srv/fileserver/team` - Accessible to team members (developers)
- `/srv/fileserver/secure` - Accessible to analysts and administrators

Commands used:
```bash
sudo mkdir -p /srv/fileserver/{public,team,secure}

## User and Group Management

- developers - For development team members
- analysts - for data analysts
- interns - For temporary staff




















Commands used:


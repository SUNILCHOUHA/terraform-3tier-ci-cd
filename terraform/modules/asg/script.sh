#!/bin/bash
set -e

# --------------------------------------------------
# Project: Production-Grade 3-Tier Infrastructure
# Author : Sunil Chouhan
# Purpose: Environment-based NGINX deployment via Terraform & CI/CD
# --------------------------------------------------

ENVIRONMENT="${environment}"

# -------- OS Detection & NGINX Install --------
if [ -f /etc/debian_version ]; then
  apt update -y
  apt install -y nginx
elif [ -f /etc/redhat-release ]; then
  yum install -y nginx
fi

systemctl enable nginx
systemctl start nginx

# -------- Environment-based Configuration --------
if [ "$ENVIRONMENT" = "dev" ]; then
  COLOR="#d1fae5"
  MESSAGE="DEV Environment"
elif [ "$ENVIRONMENT" = "stg" ]; then
  COLOR="#fef3c7"
  MESSAGE="STAGING Environment"
else
  COLOR="#fee2e2"
  MESSAGE="PRODUCTION Environment"
fi

# -------- NGINX Web Page --------
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>$MESSAGE</title>
</head>
<body style="background:$COLOR; text-align:center; font-family:Arial;">
  <h1>3-Tier Application</h1>
  <h2>$MESSAGE</h2>
  <h3>Designed & Implemented by Sunil Chouhan</h3>
  <p>Deployed using Terraform & GitHub Actions CI/CD</p>
</body>
</html>
EOF

systemctl reload nginx

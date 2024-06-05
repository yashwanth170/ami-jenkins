#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y curl
sudo apt install -y openjdk-17-jre
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins
sudo apt-get install -y nginx
sudo apt-get install -y nginx certbot python3-certbot-nginx
sudo systemctl enable jenkins
sudo systemctl enable nginx

JENKINS_URL=http://localhost:8080
JENKINS_CLI_JAR=/var/lib/jenkins/jenkins-cli.jar
sudo wget ${JENKINS_URL}/jnlpJars/jenkins-cli.jar -O $JENKINS_CLI_JAR


# Get initial admin password
ADMIN_PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

# Install desired plugins
PLUGINS="git workflow-aggregator docker-workflow maven-plugin"
for plugin in $PLUGINS; do
  java -jar $JENKINS_CLI_JAR -s $JENKINS_URL -auth admin:$ADMIN_PASSWORD install-plugin $plugin -deploy
done

# Restart Jenkins to load plugins
sudo systemctl restart jenkins

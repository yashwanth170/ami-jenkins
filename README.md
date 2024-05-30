# Packer Configuration for Building Jenkins Server AMI

This repository contains a Packer configuration file (`jenkins-config.json`) and a shell script (`script.sh`) to build an Amazon Machine Image (AMI) for a Jenkins server on AWS using Packer.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed:

- [Packer](https://www.packer.io/downloads)
- AWS IAM credentials with permissions to create EC2 instances and AMIs

## Usage

### 1. Configure Variables

Open `jenkins-config.json` in a text editor and customize the following variables as needed:

- `region`: The AWS region where the AMI will be created.
- `source_ami`: The ID of the base AMI to use as the source.
- `instance_type`: The EC2 instance type to use for building the AMI.
- `profile`: The AWS profile to use for authentication (optional).
- `ssh_username`: The username used to SSH into the EC2 instance.

### 2. Build the AMI

Run the following command to build the AMI:

```bash
packer build jenkins-json.json

The script file (`script.sh`) installs the following software on the Amazon Machine Image (AMI) during the provisioning process:

- **curl**: Command-line tool for transferring data with URLs.
- **OpenJDK 17**: Java Runtime Environment required for Jenkins.
- **Jenkins**: Automation server for continuous integration and continuous delivery (CI/CD).
- **Nginx**: Web server used for reverse proxying to Jenkins and handling SSL.
- **Certbot**: Tool for automatically enabling HTTPS on your server using Let's Encrypt certificates.

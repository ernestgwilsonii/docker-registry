#!/bin/bash

# Detect and set or inform the user to set the DOCKER_REPOSITORY_USERNiAME environment variable
if [[ -z "${DOCKER_REPOSITORY_USERNAME}" ]]; then
  # Looks like the environment variable was not set
  echo "WARNING: Environment variable was not set!"
  echo "Please set the DOCKER_REPOSITORY_USERNAME environment variable first."
  echo "Example:"
  echo "export DOCKER_REPOSITORY_USERNAME=ernestgwilsonii"
  echo " "
  exit 128;
else
  # Use the current environment variable that was detected
  echo "Environment variable DOCKER_REPOSITORY_USERNAME detected!"
  DOCKER_REPOSITORY_USERNAME="${DOCKER_REPOSITORY_USERNAME}"
fi


# Clean up old keys and directories then create a new clean directory structure
echo " "
echo "Cleaning up old directory structure and key files if they exist"
echo "###############################################################"
if [ -d cert ]; then
  mv cert cert_old.$(date +%Y-%m-%d-%H%M%S)
fi
rm -f registry-srv/cert
rm -f registry-web/cert
mkdir -p cert
mkdir -p registry-srv/cert
mkdir -p registry-web/cert
echo "done"

# Generate a new self-signed certificate
echo " "
echo "Generate a new self-signed certificate"
echo "######################################"
openssl req -nodes -newkey rsa:2048 -new -x509 -days 3650 -keyout cert/auth.key -out cert/auth.crt -subj '/C=US/ST=Pennsylvania/L=Landenberg/O=SitesExpress/OU=Cloud/CN=localhost/emailAddress=ErnestGWilsonII@gmail.com'
# Create a single usable file that the configuration can use as the self-signed certificate
cat cert/auth.key cert/auth.crt > cert/auth.pem
cp cert/* registry-srv/cert/
cp cert/* registry-web/cert/
echo "done"

# Build the Docker Registry Server image
echo " "
echo "Building a new Customized Private Docker Registry Server image"
echo "##############################################################"
cd registry-srv
docker build -t $DOCKER_REPOSITORY_USERNAME/registry-srv:latest .
echo "done"

# Build the Docker Registry Web image
echo " "
echo "Building a new Customized Private Docker Registry Web Interface image"
echo "#####################################################################"
cd ../registry-web
docker build -t $DOCKER_REPOSITORY_USERNAME/registry-web:latest .
cd ..
echo "done"

# Display the results
echo " "
echo "Docker images created locally:"
echo "REPOSITORY                              TAG                 IMAGE ID            CREATED                  SIZE"
docker images | grep $DOCKER_REPOSITORY_USERNAME/registry-
echo " "


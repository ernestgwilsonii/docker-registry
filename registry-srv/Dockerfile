FROM registry:latest
# REF: https://hub.docker.com/_/registry/

# Customized production grade Private Docker Registry Server built from the official Docker Registry
MAINTAINER "Ernest G. Wilson II" <ErnestGWilsonII@gmail.com>

# Customize the Private Docker Registry Server
COPY conf/registry-srv.yml /etc/docker/registry/config.yml
COPY cert/auth.crt /etc/docker/registry/auth.crt
COPY cert/auth.key /etc/docker/registry/auth.key
COPY cert/auth.pem /etc/docker/registry/auth.pem

# Expose Private Docker Registry Server ports
EXPOSE 5000


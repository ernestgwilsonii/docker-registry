FROM hyper/docker-registry-web:latest
# REF: https://hub.docker.com/r/hyper/docker-registry-web/

# Customized production grade Private Web Interface for Private Docker Registry Server
MAINTAINER "Ernest G. Wilson II" <ErnestGWilsonII@gmail.com>

# Customize the Private Docker Registry Web Interface
COPY conf/registry-web.yml /conf/registry-web.yml
COPY cert/auth.crt /conf/auth.crt
COPY cert/auth.key /conf/auth.key
COPY cert/auth.pem /conf/auth.pem

# Expose Private Docker Registry Web Interface ports
EXPOSE 8090


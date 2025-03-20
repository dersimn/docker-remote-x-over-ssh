FROM jlesage/baseimage-gui:alpine-3.21-v4

# Timezone
RUN    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && echo "Europe/Berlin" >  /etc/timezone

# Cosmetics
# Set the name of the application
RUN set-cont-env APP_NAME "SSH X11"

# Packages
RUN add-pkg \
        openssh-client \
        xprop

# Copy files
COPY startapp.sh  /startapp.sh
COPY ssh_config   /etc/ssh/ssh_config.d/custom.conf

# Define mountable directories.
VOLUME ["/ssh"]

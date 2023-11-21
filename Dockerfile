FROM centos:latest

# Use specific mirrors for CentOS repositories
RUN echo -e "[base]\nname=CentOS-Base\nbaseurl=http://mirror.centos.org/centos/8/BaseOS/x86_64/os/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official" > /etc/yum.repos.d/centos.repo \
    && echo -e "[appstream]\nname=CentOS-AppStream\nbaseurl=http://mirror.centos.org/centos/8/AppStream/x86_64/os/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official" > /etc/yum.repos.d/appstream.repo

# Install required packages
RUN yum install -y httpd zip unzip && \
    yum clean all && \
    rm -rf /var/cache/yum

# Add files, set working directory, and perform additional steps if needed
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Define the command to run when the container starts
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose the port used by the HTTP server
EXPOSE 80


# FROM  centos:latest
# MAINTAINER vikashashoke@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
#  ADD https://www.free-css.com/assets/files/free-css-templates/download/page265/shine.zip /var/www/html/
#  WORKDIR /var/www/html/
#  RUN unzip shine.zip
#  RUN cp -rvf shine/* .
#  RUN rm -rf shine shine.zip
#  CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#  EXPOSE 80

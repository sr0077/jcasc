FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins

# ENV CASC_JENKINS_CONFIG /var/jenkins_config/casc.yaml
# COPY casc.yaml /var/jenkins_config/casc.yaml
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JENKINS_HOME /var/jenkins_home
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
# COPY plugins /var/jenkins_home/plugins
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt --verbose



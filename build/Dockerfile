FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y build-essential wget lsb-release curl gpg redis gnupg graphviz \
                       rpm nodejs npm genisoimage jq ruby ruby-dev

# With openjdk-18-jdk there was an error when building:
# Fatal error - cannot access legacy Javac API: Unable to make field public com.sun.tools.javac.code.Type com.sun.tools.javac.tree.JCTree.type accessible:
# module jdk.compiler does not "exports com.sun.tools.javac.tree" to unnamed module @34b06c56
# So stick to openjdk-12-jdk.
RUN apt-get install -y openjdk-18-jdk
ENV JAVA_HOME='/usr/lib/jvm/java-18-openjdk-amd64'
ENV PATH="$JAVA_HOME/bin:$PATH"


# MongoDB
RUN curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
    gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
    --dearmor && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && apt-get install -y mongodb-org

RUN npm install -g ajv && \
    gem install rdf -v 3.0.13 && \
    gem install json-ld -v 3.0.2

# Install Maven

# since Maven 3.8.1, Maven comes with a default configuration to block all HTTP (insecure) repositories.
# This results in a build error. According to this SO post one could change the ~/.m2/settings.xml,
# But I didn't want to do that in Docker ...
# https://stackoverflow.com/a/67121849
RUN wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.6.3/apache-maven-3.6.3-bin.tar.gz && \
    tar -xvf apache-maven-3.6.3-bin.tar.gz && \
    mv apache-maven-3.6.3 /opt/

ENV M2_HOME='/opt/apache-maven-3.6.3'
ENV PATH="$M2_HOME/bin:$PATH"

RUN mkdir /src
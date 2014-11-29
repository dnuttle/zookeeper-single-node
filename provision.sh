sudo apt-get update > /dev/null 2>&1
# Install curl, in order to download zookeeper
apt-get install -y curl

# Install java (Oracle 7)
apt-get update > /dev/null 2>&1 \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python-software-properties \
  && rm -rf /var/lib/apt/lists/* \
  && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && add-apt-repository -y ppa:webupd8team/java \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java7-installer \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove software-properties-common python-software-properties \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/oracle-jdk7-installer

# Install zookeeper
if [ ! -d /opt/zookeeper-3.4.6 ]; then
	# Download zookeeper
	curl -s http://apache.mesi.com.ar/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz > zookeeper-3.4.6.tar.gz
	tar -C /opt -xzf zookeeper-3.4.6.tar.gz
	cp /vagrant/zoo.cfg /opt/zookeeper-3.4.6/conf/.
	mkdir /opt/zookeeper-3.4.6/data
fi
# Start zookeeper
/opt/zookeeper-3.4.6/bin/zkServer.sh start

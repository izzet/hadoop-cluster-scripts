# Hadoop Cluster Scripts

## CentOS 7

Install dependencies:

```shell
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk                # JDK
sudo yum install -y openssh-server openssh-clients    # SSH
sudo yum install -y wget                              # Utilities
```

Verify dependencies:

```shell
java -version                   # Should output OpenJDK version
readlink -f $(which java)       # Should output /bin/java location
```

Start SSH server:

```shell
sudo systemctl start sshd       # Start SSH
sudo systemctl status sshd      # Check SSH status
sudo systemctl enable sshd      # Set SSH to boot with OS
```

Install Hadoop 3.2.2:

```shell
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz
tar -xzf hadoop-3.2.2.tar.gz
mv hadoop-3.2.2 hadoop
rm hadoop-3.2.2.tar.gz
```

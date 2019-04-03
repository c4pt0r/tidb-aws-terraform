[tidb_servers]
${list_tidb}

[tikv_servers]
${list_tikv}

[pd_servers]
${list_pd}

[spark_master]
[spark_slaves]

[monitoring_servers]
${list_monitor}

[grafana_servers]
${list_monitor}

[monitored_servers:children]
tidb_servers
tikv_servers
pd_servers
spark_master
spark_slaves

## Binlog Part
[pump_servers:children]
tidb_servers

[drainer_servers]

[pd_servers:vars]
# location_labels = ["zone","rack","host"]

## Global variables
[all:vars]
deploy_dir = /home/ec2-user/deploy

## Connection
# ssh via root:
# ansible_user = root
# ansible_become = true
# ansible_become_user = tidb

# ssh via normal user
ansible_user = ec2-user

cluster_name = test-cluster

tidb_version = latest

# process supervision, [systemd, supervise]
process_supervision = systemd

timezone = America/Los_Angeles

enable_firewalld = False
# check NTP service
enable_ntpd = True
set_hostname = False

## binlog trigger
enable_binlog = False

# binlog version, "kafka" or "cluster":
binlog_version = "cluster"

# kafka cluster address for monitoring, example:
# kafka_addrs = "192.168.0.11:9092,192.168.0.12:9092,192.168.0.13:9092"
kafka_addrs = ""

# zookeeper address of kafka cluster for monitoring, example:
# zookeeper_addrs = "192.168.0.11:2181,192.168.0.12:2181,192.168.0.13:2181"
zookeeper_addrs = ""

# store slow query log into seperate file
enable_slow_query_log = False

# enable TLS authentication in the TiDB cluster
enable_tls = False

# KV mode
deploy_without_tidb = False

# Optional: Set if you already have a alertmanager server.
# Format: alertmanager_host:alertmanager_port
alertmanager_target = ""

grafana_admin_user = "admin"
grafana_admin_password = "admin"


### Collect diagnosis
collect_log_recent_hours = 2

enable_bandwidth_limit = True
# default: 10Mb/s, unit: Kbit/s
collect_bandwidth_limit = 10000

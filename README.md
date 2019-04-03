# tidb-aws-terraform
Handy terraform scripts for running TiDB on AWS

### Quick Start
1. git clone this project，and execute `terraform init`
2. modify variables.tf, fill with your aws_access_key and aws_secret_key, and the cluster topology
3. execute `terraform plan` 
4. Make sure terraform generates right plan, and execute `terraform apply`
5. After Step 4, you can see the public IP of relay-server，ssh to the replay-server, the tidb-ansible directory will be on /home/ec2-user/tidb-ansible
6. find `# ssh_args = -i aws.key -C -o ControlMaster=auto -o ControlPersist=60s`, remove the comment mark, and deploy tidb using tidb-ansible.

### Resource Overview
1. Deploy region

	* cn-northwest-1

2. Default EC2 instance type

	| type  | instanceType  | counts | typeOfSubnet|
	| :-: |:-:| :-:| :-: |
	| bastion | t2.micro   | 1 | public  |
	| tidb    | c4.4xlarge | 3 | priveta |
	| tikv    | i3.2xlarge   | 3 | private |
	| pd      | i3.xlarge | 3 | private |
	| monitor | t2.xlarge   | 1 | private |

3. Network resource

	* 1 VPC
	* 1 public subnet
	* 1 private subnet
	* 1 internet gateway
	* 1 nat gateway

5. ELB resrouce

	* tidb provides ELB, expose port 4000
	* tidb monitor ELB，expose port 3000

	> ELB is in public subnet

6. Security group
	* All the ports TiDB needs

7. Storage resource
 	* monitor node has a 200GB EBS, tikv nodes have 1.7T NVMe SSD, pd nodes have 880 GB NVMe SSD

8. AWS key pair

9. Generating Template File for TiDB ansible
	* Generate [TiDB-Ansible](https://github.com/pingcap/tidb-ansible) 's inventory.ini

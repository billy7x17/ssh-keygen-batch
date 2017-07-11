# ssh-keygen-batch
批量ssh互信脚本 shell + expect

## 背景 ##

+ kvm环境计算节点150台需要两两做ssh互信，手动安装会使人崩溃。
+ 执行此脚本程序的主机需要在互信群之外。因为known_hosts文件中并不会包含本机，因此在执行脚本结束后，互信群上的主机并不了解本机，在ssh时会出现yes/no选项，没有达到真正的互信。

## 使用方法 ##

1. 首先安装expect

		yum install expect -y

2. 将3个脚本(`scp.exp`、`sshkey.exp`、`autorun_sshkey_gen.sh`)放在互信用户目录下的某一目录下。
3. 在相同目录，创建ip.list文件，加入需要互信的ip地址或域名：

		node2
		node3
		node4

~~4. 将3个脚本赋可执行权限：~~

		chmod 777 *
		-- 暂且写成这样

~~5. 本机生成rsa公钥/私钥：~~

		ssh-keygen

~~4个交互命令一律使用回车响应~~



5. 将本机公钥放入本机的互信文件中：

		cat ~.ssh/id_rsa.pub > authorized_keys

6. `scp.exp`和`sshkey.exp`是expect脚本，无需改动，`autorun_sshkey_gen.sh`是自己编写的。

	执行`autorun_sshkey_gen.sh`脚本有2个参数，第一个是互信用户名，第二个是其ssh密码。

		./autorun_sshkey_gen.sh user userpassword  

    这样就会在ip.list文件中的这些个节点里做好互信了。

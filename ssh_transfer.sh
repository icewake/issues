使用ssh进行内网透传

内网机:
	ssh -fCNR 7000:localhost:22 root@$公网ip -p12202  #再39机器上启动一个127.0.0.1:7000的监听，反代到本地22端口
	#autossh -M 51200 -fCNR 7000:localhost:22 root@39.106.26.159 -p12202 (可选)
	-M参数，该参数设定一个监视连接状态的端口，当连接出现问题时，会进行自动重连。(因为反向代理不靠谱，会经常断开)
	-N      Do not execute a remote command.  This is useful for just forwarding ports.
	-C      Requests compression of all data (including stdin, stdout, stderr, and data for forwarded X11, TCP and UNIX-domain connections).  The
             compression algorithm is the same used by gzip(1).  Compression is desirable on modem lines and other slow connections, but will only
             slow down things on fast networks.  The default value can be set on a host-by-host basis in the configuration files; see the Compression
             option.
	-R [bind_address:]port:host:hostport
	-R [bind_address:]port:local_socket
	-R remote_socket:host:hostport
	-R remote_socket:local_socket
	-R [bind_address:]port
		Specifies that connections to the given TCP port or Unix socket on the remote (server) host are to be forwarded to the local side.
	
        This works by allocating a socket to listen to either a TCP port or to a Unix socket on the remote side.  Whenever a connection is made
        to this port or Unix socket, the connection is forwarded over the secure channel, and a connection is made from the local machine to ei‐
        ther an explicit destination specified by host port hostport, or local_socket, or, if no explicit destination was specified, ssh will act
        as a SOCKS 4/5 proxy and forward connections to the destinations requested by the remote SOCKS client.

        Port forwardings can also be specified in the configuration file.  Privileged ports can be forwarded only when logging in as root on the
        remote machine.  IPv6 addresses can be specified by enclosing the address in square brackets.

        By default, TCP listening sockets on the server will be bound to the loopback interface only.  This may be overridden by specifying a
        bind_address.  An empty bind_address, or the address ‘*’, indicates that the remote socket should listen on all interfaces.  Specifying a
        remote bind_address will only succeed if the server's GatewayPorts option is enabled (see sshd_config(5)).

        If the port argument is ‘0’, the listen port will be dynamically allocated on the server and reported to the client at run time.  When
        used together with -O forward the allocated port will be printed to the standard output.
	 
	注意：建议加上免密
	
	
	
公网机:
	root@locahos:~# cat /etc/rinetd.conf #做转发，当然也可以用nginx或者直接ssh的时候不适用localhost
	0.0.0.0 7500 127.0.0.1 7000
	#本地7500的转发到本机的7000

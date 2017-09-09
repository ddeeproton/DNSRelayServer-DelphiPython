unit PythonDNS;

interface

uses FilesManager;

procedure createVBScript(config_use_host, config_use_blackhost, config_block_all, config_cache_memory, config_display_log: string);

implementation

uses Unit1, SysUtils;


procedure createVBScript(config_use_host, config_use_blackhost, config_block_all, config_cache_memory, config_display_log: string);
var
  i: integer;
  script, dnsMaster: string;
begin
  dnsMaster := '';
  for i := 0 to form1.ListBoxDNSMaster.Items.Count -1 do
  begin
    if not (dnsMaster = '') then dnsMaster := dnsMaster + ',';
    dnsMaster := dnsMaster + '''' + form1.ListBoxDNSMaster.Items.Strings[i] + '''';
  end;

  script :=     '#!/usr/bin/env python'#13#10+
    'import sys, subprocess'#13#10+
    'import socket'#13#10+
    'import dns.resolver'#13#10+
    'from dns.exception import DNSException'#13#10+
    'import time'#13#10+
    'import sys'#13#10+
    'import re'#13#10+
    'import os.path'#13#10+
    'import threading'#13#10+
    ''#13#10+
    '#import MySQLdb'#13#10+
    ''#13#10+
    '#============================='#13#10+
    '# FastDNS version 0.1'#13#10+
    '#============================='#13#10+
    '# Requirements:'#13#10+
    '# [Pyhton]'#13#10+
    '#  http://www.python.org/getit/'#13#10+
    '#'#13#10+
    '# [dnspython]'#13#10+
    '#  http://www.dnspython.org/'#13#10+
    '#'#13#10+
    '# [MySQL-python]'#13#10+
    '#  http://sourceforge.net/projects/mysql-python/'#13#10+
    '#'#13#10+
    '# [MySQL server]'#13#10+
    '#  http://dev.mysql.com/downloads/'#13#10+
    '#'#13#10+
    '# Create table SQL'#13#10+
    '# CREATE TABLE IF NOT EXISTS `dnscache` (`domain` varchar(255) NOT NULL,`ip` varchar(15) NOT NULL,`banned` tinyint(1) NOT NULL, UNIQUE KEY `domain` (`domain`)) TYPE=InnoDB;'#13#10+
    '#============================='#13#10+
    ''#13#10+
    '#============================='#13#10+
    '# CONFIGURATION'#13#10+
    '#============================='#13#10+
    ''#13#10+
    ''#13#10+
    '# MySQL'#13#10+
    'config_dbhost = "192.168.0.1"'#13#10+
    'config_dbuser = "root2"'#13#10+
    'config_dbpasswd = ""'#13#10+
    'config_dbname = "DNSdata"'#13#10+
    'config_dbtable = "dnscache"'#13#10+
    'config_dbport = 33006'#13#10+
    ''#13#10+
    '# Relay DNS'#13#10+
    '#config_dnsrelay = [''209.244.0.3'',''209.244.0.4'']'#13#10+
    'config_dnsrelay = ['+dnsMaster+']'#13#10+
    'config_dnstimeout = 5'#13#10+
    ''#13#10+
    '#Client DNS'#13#10+
    'config_cache_sql = 0  # [ 0 | 1 ] utilise la base MySQL en priorite'#13#10+
    'config_cache_memory = '+config_cache_memory+' # [ 0 | 1 ] utilise la memoire pour stocker les resolutions'#13#10+
    'config_use_host = '+config_use_host+' # [ 0 | 1 ] utilise le fichier host'#13#10+
    'config_use_blackhost = '+config_use_blackhost+' # [ 0 | 1 ] utilise le fichier blackhost'#13#10+
    ''#13#10+
    '# Server DNS'#13#10+
    'config_block_all = '+config_block_all+' # [ 0 | 1 ] utilise le fichier blackhost'#13#10+
    ''#13#10+
    'def getArgv(varname, default):'#13#10+
    '	result = default'#13#10+
    '	if varname in sys.argv:'#13#10+
    '		i = sys.argv.index(varname)'#13#10+
    '		if i > -1 and len(sys.argv) > i:'#13#10+
    '			result = sys.argv[i+1]'#13#10+
    '	return result'#13#10+
    ''#13#10+
    'config_dnsip = getArgv(''config_dnsip'', ''0.0.0.0'')'#13#10+
    'config_hostfile = getArgv(''config_hostfile'', ''hosts.txt'')'#13#10+
    'config_blackhostfile = getArgv(''config_blackhost'', ''blackhost.txt'')'#13#10+
    'config_blackhostfile = getArgv(''config_blackhost'', ''blackhost.txt'')'#13#10+
    'config_dircustomhost = getArgv(''config_dircustomhost'', ''customhost'')'#13#10+
    ''#13#10+
    '			'#13#10+
    'config_dnsport = '+IntToStr(Form1.SpinPort.Value)+#13#10+
    'config_delayerror = 1'#13#10+
    ''#13#10+
    'config_display = '+config_display_log+#13#10+
    ''#13#10+
    '# Banned countries'#13#10+
    '#config_banned_countries = [''us'',''uk'',''il'',''ie'']'#13#10+
    '#config_banned_countries = [''il'']'#13#10+
    'config_banned_countries = []'#13#10+
    ''#13#10+
    'cache_domains = {}'#13#10+
    ''#13#10+
    '#============================='#13#10+
    '# SQL'#13#10+
    '#============================='#13#10+
    ''#13#10+
    ''#13#10+
    ''#13#10+
    ''#13#10+
    'class DNSClient:'#13#10+
    '	def __init__(self, nameservers, timeout):'#13#10+
    '		self.res = dns.resolver.Resolver()'#13#10+
    '		self.res.nameservers = nameservers'#13#10+
    '		self.res.timeout = timeout'#13#10+
    '		self.res.lifetime = timeout'#13#10+
    ''#13#10+
    '	def dnsResolve(self, domain):'#13#10+
    '		res = 0'#13#10+
    '		try:'#13#10+
    '			answer = self.res.query(domain, "A")'#13#10+
    '			res = "%s" % answer[0]'#13#10+
    '		except dns.resolver.NoAnswer:'#13#10+
    '			#print "Error: No AAAA record for", dnss.domain," ", data'#13#10+
    '			sys.stdout.flush()'#13#10+
    '		except dns.resolver.NXDOMAIN:'#13#10+
    '			#print "Error: The name ", dnss.domain, " does not exist"'#13#10+
    '			sys.stdout.flush()'#13#10+
    '		except DNSException:'#13#10+
    '			#print ''Error: DNS Exception: '', dnss.domain'#13#10+
    '			sys.stdout.flush()'#13#10+
    '		return res'#13#10+
    ''#13#10+
    'class DNSServer:'#13#10+
    '	def __init__(self, ip, port, delayerror):'#13#10+
    '		self.udps = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)'#13#10+
    '		try:'#13#10+
    '			self.udps.bind((ip,port))'#13#10+
    '		except:'#13#10+
    '			print "Error: Port ",port," already used (wait ",delayerror," seconds before close)"'#13#10+
    '			sys.stdout.flush()'#13#10+
    '			time.sleep(delayerror)'#13#10+
    '			sys.exit(0)'#13#10+
    ''#13#10+
    '	def recieveQuery(self):'#13#10+
    '		try:'#13#10+
    '			return self.udps.recvfrom(1024)'#13#10+
    '		except:'#13#10+
    '			#print "Error: recieving data on UDP server"'#13#10+
    '			sys.stdout.flush()'#13#10+
    ''#13#10+
    '	def sendQuery(self, answer, addr):'#13#10+
    '		self.udps.sendto(answer, addr)'#13#10+
    ''#13#10+
    '	def close(self):'#13#10+
    '		self.udps.close()'#13#10+
    '		print ''Close'''#13#10+
    '		sys.stdout.flush()'#13#10+
    ''#13#10+
    'class DNSQuery:'#13#10+
    '	def __init__(self, data):'#13#10+
    '		try:'#13#10+
    '			self.data=data'#13#10+
    '			self.domain='''''#13#10+
    '			#tipo : Opcode query type =  [ standard (0) | inverse (1) | server status (2) ]'#13#10+
    '			tipo = (ord(data[2]) >> 3) & 15	 # Opcode bits'#13#10+
    '			if tipo == 0:					 # Standard query'#13#10+
    '				ini=12'#13#10+
    '				lon=ord(data[ini])'#13#10+
    '				while lon != 0:'#13#10+
    '					self.domain+=data[ini+1:ini+lon+1]+''.'''#13#10+
    '					ini+=lon+1'#13#10+
    '					lon=ord(data[ini])'#13#10+
    '		except:'#13#10+
    '			return ""'#13#10+
    ''#13#10+
    '	def dnsAnswer(self, ip):'#13#10+
    '		packet='''''#13#10+
    '		if self.domain and len(self.domain) > 0:'#13#10+
    '			packet+=self.data[:2] + "\x81\x80"'#13#10+
    '			packet+=self.data[4:6] + self.data[4:6] + ''\x00\x00\x00\x00''	 # Questions and Answers Counts'#13#10+
    '			packet+=self.data[12:]											 # Original Domain Name Question'#13#10+
    '			packet+=''\xc0\x0c''												 # Pointer to domain name'#13#10+
    '			packet+=''\x00\x01\x00\x01\x00\x00\x00\x3c\x00\x04''				 # Response type, ttl and resource data length -> 4 bytes'#13#10+
    '			try:'#13#10+
    '				packet+=str.join('''',map(lambda x: chr(int(x)), ip.split(''.''))) 	 # 4bytes of IP'#13#10+
    '			except:'#13#10+
    '				return ""'#13#10+
    '		return packet'#13#10+
    ''#13#10+
    '	def checkHost(self, domain, hostfile):'#13#10+
    '		domain = domain[:-1]'#13#10+
    '		res = '''''#13#10+
    '		if os.path.isfile(hostfile) == False:'#13#10+
    '			return ""'#13#10+
    '		#fp = open(''C:\WINDOWS\system32\drivers\etc\hosts'', ''r'')'#13#10+
    '		fp = open(hostfile, ''r'')'#13#10+
    '		#fp = open(''/mnt/sdcard2/!prog/hosts'', ''r'')'#13#10+
    '		for line in fp.readlines():'#13#10+
    '			#print line'#13#10+
    '			filehost_domain = line.split("	")[1]'#13#10+
    '			if "*" in filehost_domain:'#13#10+
    '				filehost_domain = filehost_domain.replace("*","")'#13#10+
    '				if re.search(filehost_domain[:-1], domain):'#13#10+
    '					res = line.split("	")[0]'#13#10+
    '			else:'#13#10+
    '				if "	"+domain in line:'#13#10+
    '					res = line.split("	")[0]'#13#10+
    '		fp.close()'#13#10+
    '		if res <> "":'#13#10+
    '			if res[0] == "#":'#13#10+
    '				res = '''''#13#10+
    '		return res'#13#10+
    ''#13#10+
    '	def checkBlackHost(self, domain, blackhostfile):'#13#10+
    '		domain = domain[:-1]'#13#10+
    '		res = '''''#13#10+
    '		if os.path.isfile(blackhostfile) == False:'#13#10+
    '			return '''''#13#10+
    '		fp = open(blackhostfile, ''r'')'#13#10+
    '		for line in fp.readlines():'#13#10+
    '			if re.search(line[:-1], domain):'#13#10+
    '				res = ''127.0.0.9'''#13#10+
    '			#print '';EOL;''+line+'' in ''+domain+'';EOL;'''#13#10+
    '			#if domain.find(line) != -1:'#13#10+
    '			#try:'#13#10+
    '			#	domain.index(line)'#13#10+
    '			#except:'#13#10+
    '			#		print '' NO;EOL;'''#13#10+
    '			#	res = ''127.0.0.1'''#13#10+
    '			#else:'#13#10+
    '			#	print '' YES;EOL;'''#13#10+
    '			#else:'#13#10+
    '			#	print '' NO;EOL;'''#13#10+
    '		fp.close()'#13#10+
    '		return res'#13#10+
    ''#13#10+
    '	def onlyDomain(self, domain):'#13#10+
    '		d = domain[:-1]'#13#10+
    '		data = d.split(".")'#13#10+
    '		if len(data) <= 2:'#13#10+
    '			return d'#13#10+
    '		result=""'#13#10+
    '		start = len(data) - 2'#13#10+
    '		for i in range(start,len(data),1):'#13#10+
    '			result = result + data[i] + "."'#13#10+
    '		if result <> '''':'#13#10+
    '			return result[:-1]'#13#10+
    ''#13#10+
    ''#13#10+
    '	def addToCache(self, ipclient, domain, IPHost):'#13#10+
    '		if not ipclient in cache_domains:'#13#10+
    '			cache_domains[ipclient] = {}'#13#10+
    '		if not domain in cache_domains[ipclient]:'#13#10+
    '			cache_domains[ipclient][domain] = IPHost'#13#10+
    ''#13#10+
    '	def resolveDomain(self, domain, idstatus, dnss, ipclient):'#13#10+
    '		if config_block_all == 1:'#13#10+
    '			return "127.0.0.3"'#13#10+
    '		if config_cache_memory == 1:'#13#10+
    '			if ipclient in cache_domains:'#13#10+
    '				if domain in cache_domains[ipclient]:'#13#10+
    '					return cache_domains[ipclient][domain]'#13#10+
    '				'#13#10+
    '		if ".in-addr.arpa" in domain:'#13#10+
    '			return "127.0.0.2"'#13#10+
    ''#13#10+
    '		if os.path.isdir(config_dircustomhost):'#13#10+
    '			customhostfile = config_dircustomhost + "/" + ipclient + "_hostfile.txt"'#13#10+
    '			if os.path.isfile(customhostfile):'#13#10+
    '				IPHost = self.checkHost(domain, customhostfile)'#13#10+
    '				if config_use_host == 1 and IPHost <> '''':'#13#10+
    '					#if config_display:'#13#10+
    '					#	print "Host file domain:"'#13#10+
    '					self.addToCache(ipclient, domain, IPHost)'#13#10+
    '					return IPHost'#13#10+
    ''#13#10+
    '		if os.path.isdir(config_dircustomhost):'#13#10+
    '			customblackhostfile = config_dircustomhost + "/" + ipclient + "_blackhostfile.txt"'#13#10+
    '			if os.path.isfile(customblackhostfile):'#13#10+
    '				if config_use_blackhost == 1:'#13#10+
    '					IPHost = self.checkBlackHost(domain, customblackhostfile)'#13#10+
    '					if IPHost <> '''':'#13#10+
    '						#if config_display:'#13#10+
    '						#	print "Host file domain:"'#13#10+
    '						self.addToCache(ipclient, domain, IPHost)'#13#10+
    '						return IPHost'#13#10+
    '		'#13#10+
    '		if config_use_host == 1:'#13#10+
    '			IPHost = self.checkHost(domain, config_hostfile)'#13#10+
    '			if IPHost <> '''':'#13#10+
    '				#if config_display:'#13#10+
    '				#	print "Host file domain:"'#13#10+
    '				self.addToCache(ipclient, domain, IPHost)'#13#10+
    '				return IPHost'#13#10+
    ''#13#10+
    '		if config_use_blackhost == 1:'#13#10+
    '			IPHost = self.checkBlackHost(domain, config_blackhostfile)'#13#10+
    '			if IPHost <> '''':'#13#10+
    '				self.addToCache(ipclient, domain, IPHost)'#13#10+
    '				return IPHost'#13#10+
    ''#13#10+
    '		d = self.onlyDomain(domain)'#13#10+
    '		nameservers = config_dnsrelay'#13#10+
    '		IPHost = dnsc.dnsResolve(domain) # Ask the master DNS server'#13#10+
    '		if IPHost == 0: # Network error? Let''s try again!'#13#10+
    '			IPHost = dnsc.dnsResolve(domain)'#13#10+
    '			if IPHost == 0:'#13#10+
    '				return "127.0.0.4"'#13#10+
    '			'#13#10+
    '		#db.sqlsetdomain(domain, IPHost) # Add IP in database'#13#10+
    '		if IPHost <> 0 and IPHost <> '''':'#13#10+
    '			self.addToCache(ipclient, domain, IPHost)'#13#10+
    '		return IPHost'#13#10+
    ''#13#10+
    ''#13#10+
    ''#13#10+
    'class SQLConnexion:'#13#10+
    '	def __init__(self, dbhost, dbport, dbuser, dbpasswd, dbname, dbtable):'#13#10+
    ''#13#10+
    '		time.sleep(5)'#13#10+
    '		self.db = MySQLdb.connect(host=dbhost, port=dbport, user=dbuser, passwd=dbpasswd, db=dbname)'#13#10+
    '		self.cur = self.db.cursor()'#13#10+
    '		self.tablecache = dbtable '#13#10+
    '		try:'#13#10+
    '			time.sleep(5)'#13#10+
    '			self.db = MySQLdb.connect(host=dbhost, port=dbport, user=dbuser, passwd=dbpasswd, db=dbname)'#13#10+
    '			self.cur = self.db.cursor()'#13#10+
    '			self.tablecache = dbtable    '#13#10+
    '		except:'#13#10+
    '			print "Error connexion database MySQL"'#13#10+
    '			sys.stdout.flush()'#13#10+
    '			time.sleep(5)'#13#10+
    '			sys.exit(0)'#13#10+
    ''#13#10+
    '	def close(self):'#13#10+
    '		self.cur.close()'#13#10+
    '		self.db.close()'#13#10+
    ''#13#10+
    '	def sqlquery(self, query):'#13#10+
    '		try:'#13#10+
    '			self.cur.execute(query)'#13#10+
    '		except MySQLdb.Error, e:'#13#10+
    '			print "Error %d: %s" % (e.args[0], e.args[1])'#13#10+
    '			print "Query SQL \n %s" % query'#13#10+
    '			sys.stdout.flush()'#13#10+
    '			self.db.rollback()'#13#10+
    '			time.sleep(5)'#13#10+
    ''#13#10+
    '	def sqlgetdomain(self, domain):'#13#10+
    '		res = 0'#13#10+
    '		self.sqlquery("SELECT * FROM `"+self.tablecache+"` WHERE `domain` = ''"+domain[:-1]+"'';")'#13#10+
    '		resultcount = int(self.cur.rowcount)'#13#10+
    '		if resultcount > 0:'#13#10+
    '			q = self.cur.fetchall()'#13#10+
    '			ip = q[0][1]'#13#10+
    '			banned = q[0][2]'#13#10+
    '			if banned == 1:'#13#10+
    '				res = "127.0.0.5"'#13#10+
    '			else:'#13#10+
    '				res = ip'#13#10+
    '		return res'#13#10+
    ''#13#10+
    '	def sqlsetdomain(self, domain, ip):'#13#10+
    '		self.sqlquery("DELETE FROM `"+self.tablecache+"` WHERE `domain` = ''"+domain[:-1]+"'';")'#13#10+
    '		self.db.commit()'#13#10+
    '		self.sqlquery("INSERT INTO `"+self.tablecache+"` (`domain` ,`ip` ,`banned`) VALUES (''"+domain[:-1]+"'', ''"+ip+"'', ''0'');")'#13#10+
    '		self.db.commit()'#13#10+
    ''#13#10+
    '	def sqlgetcountry(self, ip):'#13#10+
    '		self.sqlquery("SELECT country FROM ip2nation WHERE ip < INET_ATON(''"+ip+"'') ORDER BY ip DESC LIMIT 0,1;")'#13#10+
    '		resultcount = int(self.cur.rowcount)'#13#10+
    '		if resultcount > 0:'#13#10+
    '			q = self.cur.fetchall()'#13#10+
    '			country = q[0][0]'#13#10+
    '			return country'#13#10+
    '		else:'#13#10+
    '			return "unkown"'#13#10+
    ''#13#10+
    '	def sqlgetcountryname(self, ip):'#13#10+
    '		self.sqlquery("SELECT c.country FROM ip2nationCountries c, ip2nation i WHERE i.ip < INET_ATON(''"+ip+"'') AND  c.code = i.country ORDER BY i.ip DESC LIMIT 0,1;")'#13#10+
    '		resultcount = int(self.cur.rowcount)'#13#10+
    '		if resultcount > 0:'#13#10+
    '			q = self.cur.fetchall()'#13#10+
    '			country = q[0][0]'#13#10+
    '			return country'#13#10+
    '		else:'#13#10+
    '			return "unkown"'#13#10+
    ''#13#10+
    'def serveClient(data, addr):'#13#10+
    '	#data, addr = req # recieve UDP data (usually on port 53)'#13#10+
    '	dnss = DNSQuery(data) # Parse DNS query'#13#10+
    '	'#13#10+
    '	isArpa = ".in-addr.arpa" in dnss.domain'#13#10+
    '	country = ''unkown'''#13#10+
    '	answer = ''127.0.0.6'''#13#10+
    '	if isArpa:'#13#10+
    '		#print ''isArpa'''#13#10+
    '		ip = dnss.domain.split(".") '#13#10+
    '		answer = ip[3]+"."+ip[2]+"."+ip[1]+"."+ip[0]'#13#10+
    '		#country = db.sqlgetcountry(answer)'#13#10+
    '		#countryname = db.sqlgetcountryname(answer)'#13#10+
    '		#if country in config_banned_countries:'#13#10+
    '		#answer = answer+"."+country+"."+countryname'#13#10+
    '		#TEST'#13#10+
    '		#answer = ''127.0.0.1'''#13#10+
    '		#print "arpa adress"'#13#10+
    '	else:'#13#10+
    '		#print "normal domain"'#13#10+
    '		'#13#10+
    '		if config_cache_sql == 1: # if domain exists'#13#10+
    '			#UPDATE d''adresse deja existante'#13#10+
    '			#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server'#13#10+
    '			#db.sqlsetdomain(dnss.domain, answer) # Add IP in database'#13#10+
    '			answer = db.sqlgetdomain(dnss.domain) # Check if domain exists in database'#13#10+
    '			countryname = db.sqlgetcountryname(answer)'#13#10+
    '			country = db.sqlgetcountry(answer)'#13#10+
    '			if country in config_banned_countries and addr[0] == ''8.8.8.20'':'#13#10+
    '				answer = ''127.0.0.7'''#13#10+
    ''#13#10+
    '			udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user'#13#10+
    ''#13#10+
    '		else: # if it''s a new domain'#13#10+
    '			#print "New domain:"'#13#10+
    '			answer = dnss.resolveDomain(dnss.domain, 2, dnss, addr[0]) # Ask the Primary DNS server'#13#10+
    '			#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server'#13#10+
    '			if answer == 0 :'#13#10+
    '				answer = "127.0.0.8"'#13#10+
    '			else:'#13#10+
    '				#db.sqlsetdomain(dnss.domain, answer) # Add IP in database'#13#10+
    '				#countryname = db.sqlgetcountryname(answer)'#13#10+
    '				#country = db.sqlgetcountry(answer)'#13#10+
    ''#13#10+
    '				#if country in config_banned_countries and addr[0] == ''8.8.8.20'':'#13#10+
    '				#	answer = ''127.0.0.1'''#13#10+
    ''#13#10+
    '				udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user'#13#10+
    ''#13#10+
    '	# Display log'#13#10+
    '	heure = time.strftime(''%d.%m.%y; %H:%M:%S'',time.localtime())'#13#10+
    ''#13#10+
    '	'#13#10+
    '	#if answer == ''127.0.0.1'':'#13#10+
    '	#	countryname = '''''#13#10+
    '	#	country = ''local'''#13#10+
    '	#else:'#13#10+
    '	#if answer != ''127.0.0.1'':'#13#10+
    '	#	db.sqlsetdomain(dnss.domain, answer) # Add IP in database'#13#10+
    '	if isArpa == False and config_display == True:'#13#10+
    '		print ''%s; %s; %s; %s; %s;EOL;'' % (heure, config_dnsip, addr[0], answer, dnss.domain)'#13#10+
    '	sys.stdout.flush()'#13#10+
    ''#13#10+
    '	'#13#10+
    'def waitClients():'#13#10+
    '	try:'#13#10+
    '		while 1:'#13#10+
    '			req = udps.recieveQuery() # recieve UDP data (usually on port 53)'#13#10+
    '			if not req:'#13#10+
    '				continue'#13#10+
    '			#serveClient(req)'#13#10+
    '			#t = threading.Thread(target=serveClient, args=(req, conn, address))'#13#10+
    '			t = threading.Thread(target=serveClient, args=(req))'#13#10+
    '			t.daemon = True'#13#10+
    '			t.start()'#13#10+
    '	except KeyboardInterrupt:'#13#10+
    '		udps.close()'#13#10+
    ''#13#10+
    ''#13#10+
    'if __name__ == ''__main__'':'#13#10+
    '	print ''Started ''+config_dnsip+'';EOL;'''#13#10+
    '	sys.stdout.flush()'#13#10+
    '	if config_cache_sql == 1:'#13#10+
    '		db = SQLConnexion(config_dbhost, config_dbport, config_dbuser, config_dbpasswd, config_dbname, config_dbtable) # SQL Connexion'#13#10+
    '	dnsc = DNSClient(config_dnsrelay, config_dnstimeout) # DNS Client'#13#10+
    '	udps = DNSServer(config_dnsip, config_dnsport, config_delayerror) # DNS Server'#13#10+
    '	waitClients()'#13#10+
    ''#13#10+
    '';

  WriteInFile(Form1.DataDirectoryPath + 'relayDNS.py', script);
end;



end.

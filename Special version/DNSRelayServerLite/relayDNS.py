#!/usr/bin/env python
import sys, subprocess
import socket
import dns.resolver
from dns.exception import DNSException
import time
import sys
import re
import os.path
import threading

#import MySQLdb

#=============================
# FastDNS version 0.1
#=============================
# Requirements:
# [Pyhton]
#  http://www.python.org/getit/
#
# [dnspython]
#  http://www.dnspython.org/
#
# [MySQL-python]
#  http://sourceforge.net/projects/mysql-python/
#
# [MySQL server]
#  http://dev.mysql.com/downloads/
#
# Create table SQL
# CREATE TABLE IF NOT EXISTS `dnscache` (`domain` varchar(255) NOT NULL,`ip` varchar(15) NOT NULL,`banned` tinyint(1) NOT NULL, UNIQUE KEY `domain` (`domain`)) TYPE=InnoDB;
#=============================

#=============================
# CONFIGURATION
#=============================


# MySQL
config_dbhost = "192.168.0.1"
config_dbuser = "root2"
config_dbpasswd = ""
config_dbname = "DNSdata"
config_dbtable = "dnscache"
config_dbport = 33006

# Relay DNS
#config_dnsrelay = ['209.244.0.3','209.244.0.4']
config_dnsrelay = ['209.244.0.3','209.244.0.4']
config_dnstimeout = 5

#Client DNS
config_cache_sql = 0  # [ 0 | 1 ] utilise la base MySQL en priorite
config_cache_memory = 1 # [ 0 | 1 ] utilise la memoire pour stocker les resolutions

def getArgv(varname, default):
	result = default
	if varname in sys.argv:
		i = sys.argv.index(varname)
		if i > -1 and len(sys.argv) > i:
			result = sys.argv[i+1]
	return result

config_dnsip = getArgv('config_dnsip', '0.0.0.0')
config_hostfile = getArgv('config_hostfile', 'hosts.txt')
config_blackhostfile = getArgv('config_blackhost', 'blackhost.txt')
config_dircustomhost = getArgv('config_dircustomhost', 'customhost')

			
config_dnsport = 53
config_delayerror = 1

config_display = True

# Banned countries
#config_banned_countries = ['us','uk','il','ie']
#config_banned_countries = ['il']
config_banned_countries = []

currentDir = os.path.dirname(os.path.realpath(__file__))

cache_domains = None
cache_host = {}
cache_blackhost = None

#=============================
# DNS Server
#=============================




class DNSClient:
	def __init__(self, nameservers, timeout):
		self.res = dns.resolver.Resolver()
		self.res.nameservers = nameservers
		self.res.timeout = timeout
		self.res.lifetime = timeout

	def dnsResolve(self, domain):
		res = 0
		try:
			answer = self.res.query(domain, "A")
			res = "%s" % answer[0]
		except dns.resolver.NoAnswer:
			#print "Error: No AAAA record for", dnss.domain," ", data
			sys.stdout.flush()
		except dns.resolver.NXDOMAIN:
			#print "Error: The name ", dnss.domain, " does not exist"
			sys.stdout.flush()
		except DNSException:
			#print 'Error: DNS Exception: ', dnss.domain
			sys.stdout.flush()
		return res

class DNSServer:
	def __init__(self, ip, port, delayerror):
		self.udps = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
		try:
			self.udps.bind((ip,port))
		except:
			print "Error: Port ",port," already used (wait ",delayerror," seconds before close)"
			sys.stdout.flush()
			time.sleep(delayerror)
			sys.exit(0)

	def recieveQuery(self):
		try:
			return self.udps.recvfrom(1024)
		except:
			#print "Error: recieving data on UDP server"
			sys.stdout.flush()

	def sendQuery(self, answer, addr):
		self.udps.sendto(answer, addr)

	def close(self):
		self.udps.close()
		print 'Close'
		sys.stdout.flush()

class DNSQuery:
	def __init__(self, data):
		try:
			if data == None:
				return None
			self.data=data
			self.domain=''
			#tipo : Opcode query type =  [ standard (0) | inverse (1) | server status (2) ]
			tipo = (ord(data[2]) >> 3) & 15	 # Opcode bits
			if tipo == 0:					 # Standard query
				ini=12
				lon=ord(data[ini])
				while lon != 0:
					self.domain+=data[ini+1:ini+lon+1]+'.'
					ini+=lon+1
					lon=ord(data[ini])
		except:
			return ""

	def dnsAnswer(self, ip):
		packet=''
		if self.domain and len(self.domain) > 0:
			packet+=self.data[:2] + "\x81\x80"
			packet+=self.data[4:6] + self.data[4:6] + '\x00\x00\x00\x00'	 # Questions and Answers Counts
			packet+=self.data[12:]											 # Original Domain Name Question
			packet+='\xc0\x0c'												 # Pointer to domain name
			packet+='\x00\x01\x00\x01\x00\x00\x00\x3c\x00\x04'				 # Response type, ttl and resource data length -> 4 bytes
			try:
				packet+=str.join('',map(lambda x: chr(int(x)), ip.split('.'))) 	 # 4bytes of IP
			except:
				return ""
		return packet

	def clearCache(self):
		global cache_domains, cache_host, cache_blackhost
		cache_domains = None
		cache_domains = {}
		cache_host = None
		cache_host = {}
		self.loadHostfile(config_hostfile)
		cache_blackhost = None
		cache_blackhost = {}
		self.loadBlackHost(config_blackhostfile)
		print "Cache cleared;EOL;"

	def loadHostfile(self, hostfile):
		global cache_host
		if hostfile in cache_host:
			return
		cache_host[hostfile] = None
		cache_host[hostfile] = {}
		if os.path.isfile(hostfile) == True:
			fp = open(hostfile, 'r')
			for line in fp.readlines():
				charSplit = ""
				if re.search(" ", line):
					charSplit = " "
				if re.search("	", line):
					charSplit = "	"
				if charSplit <> "":
					ip = line.split(charSplit)[0]
					domain = line.split(charSplit)[1]
					domain = domain[:-1]
					cache_host[hostfile][domain] = ip
			fp.close()

	def loadBlackHost(self, hostfile):
		global cache_blackhost
		if cache_blackhost == None:
			self.clearCache()
		#if hostfile in cache_blackhost:
		#	if domain in cache_blackhost[hostfile]:
		#		return cache_blackhost[hostfile][domain]
		#print "loadBlackHost"
		cache_blackhost[hostfile] = None
		cache_blackhost[hostfile] = []
		if os.path.isfile(hostfile) == True:
			fp = open(hostfile, 'r')
			for line in fp.readlines():
				domain = line[:-1]
				ip = '127.0.0.9'
				#print "%s => %s", domain, ip
				#cache_blackhost[hostfile][domain] = ip
				cache_blackhost[hostfile].append(domain)
			fp.close()

	def checkHost(self, domain, hostfile):
		global cache_host
		domain = domain[:-1]
		#self.loadHostfile(hostfile)
		if hostfile in cache_host:
			if domain in cache_host[hostfile]:
				return cache_host[hostfile][domain]
		return ""
		'''
		res = ''
		if os.path.isfile(hostfile) == False:
			return ""
		#fp = open('C:\WINDOWS\system32\drivers\etc\hosts', 'r')
		fp = open(hostfile, 'r')
		#fp = open('/mnt/sdcard2/!prog/hosts', 'r')
		for line in fp.readlines():
			#print line
			checkcom = line.replace(" ", "")
			if checkcom <> "#" and re.search("	", line):
				charSplit = ""
				if re.search(" ", line):
					charSplit = " "
				if re.search("	", line):
					charSplit = "	"
				if charSplit <> "":
					filehost_domain = line.split(charSplit)[1]
					if "*" in filehost_domain:
						filehost_domain = filehost_domain.replace("*","")
						if re.search(filehost_domain[:-1], domain):
							res = line.split(charSplit)[0]
					else:
						if "	"+domain in line:
							res = line.split(charSplit)[0]
		fp.close()
		if res <> "":
			if res[0] == "#":
				res = ''
		return res
		'''

	def checkBlackHost(self, domain, blackhostfile):
		global cache_blackhost
		domain = domain[:-1]
		#print "blackhostfile = "
		#print blackhostfile
		if cache_blackhost == None:
			#print "<loadBlackHost> 1"
			self.loadBlackHost(blackhostfile)
		if blackhostfile in cache_blackhost:
			for bdomain in cache_blackhost[blackhostfile]:
				#print bdomain
				if bdomain in domain:
					#print "%s => %s", bdomain, domain
					return "127.0.0.9"
		return ""
		'''
		res = ''
		if os.path.isfile(blackhostfile) == False:
			return ''
		fp = open(blackhostfile, 'r')
		for line in fp.readlines():
			if re.search(line[:-1], domain):
				res = '127.0.0.9'
			#print ';EOL;'+line+' in '+domain+';EOL;'
			#if domain.find(line) != -1:
			#try:
			#	domain.index(line)
			#except:
			#		print ' NO;EOL;'
			#	res = '127.0.0.1'
			#else:
			#	print ' YES;EOL;'
			#else:
			#	print ' NO;EOL;'
		fp.close()
		return res
		'''

	def onlyDomain(self, domain):
		d = domain[:-1]
		data = d.split(".")
		if len(data) <= 2:
			return d
		result=""
		start = len(data) - 2
		for i in range(start,len(data),1):
			result = result + data[i] + "."
		if result <> '':
			return result[:-1]


	def addToCache(self, ipclient, domain, IPHost):
		global cache_domains
		if not ipclient in cache_domains:
			cache_domains[ipclient] = {}
		if not domain in cache_domains[ipclient]:
			cache_domains[ipclient][domain] = IPHost

	def checkAction(self):
		f = currentDir + "/action_clear_cache.txt"
		if os.path.isfile(f) == True:
			self.clearCache()
			os.remove(f)

	def resolveDomain(self, domain, idstatus, dnss, ipclient):
		#print "<resolveDomain>"
		global cache_domains
		if cache_domains == None:
			self.clearCache()
		self.checkAction()
		if os.path.isfile(currentDir + "/disableAll.cfg") == True:
			#print "<isDisableAll>"
			return "127.0.0.3"
		if config_cache_memory == 1:
			if ipclient in cache_domains:
				if domain in cache_domains[ipclient]:
					#print "<isCacheDomain>"
					return cache_domains[ipclient][domain]
				
		if ".in-addr.arpa" in domain:
			#print "<ARPA>"
			return "127.0.0.2"

		if os.path.isdir(config_dircustomhost):
			customhostfile = config_dircustomhost + "/" + ipclient + "_hostfile.txt"
			if os.path.isfile(customhostfile):
				if os.path.isfile(currentDir + "/disableHost.cfg") == False :
					IPHost = self.checkHost(domain, customhostfile)
					if IPHost <> '':
						#if config_display:
						#	print "Host file domain:"
						self.addToCache(ipclient, domain, IPHost)
						#print "<isCustomHost>"
						return IPHost

		if os.path.isdir(config_dircustomhost):
			customblackhostfile = config_dircustomhost + "/" + ipclient + "_blackhost.txt"
			if os.path.isfile(customblackhostfile):
				if os.path.isfile(currentDir + "/disableBlackhost.cfg") == False:
					IPHost = self.checkBlackHost(domain, customblackhostfile)
					if IPHost <> '':
						#if config_display:
						#	print "Host file domain:"
						self.addToCache(ipclient, domain, IPHost)
						#print "<isCustomBlackHost>"
						return IPHost
		
		if os.path.isfile(currentDir + "/disableHost.cfg") == False:
			IPHost = self.checkHost(domain, config_hostfile)
			if IPHost <> '':
				#if config_display:
				#	print "Host file domain:"
				self.addToCache(ipclient, domain, IPHost)
				#print "<isDisabled>"
				return IPHost

		if os.path.isfile(currentDir + "/disableBlackhost.cfg") == False:
			#print "<CheckBlackHost1>"
			IPHost = self.checkBlackHost(domain, config_blackhostfile)
			#print IPHost
			if IPHost <> '':
				self.addToCache(ipclient, domain, IPHost)
				#print "<isBlackHost>"
				return IPHost

		d = self.onlyDomain(domain)
		nameservers = config_dnsrelay
		IPHost = dnsc.dnsResolve(domain) # Ask the master DNS server
		if IPHost == 0: # Network error? Let's try again!
			IPHost = dnsc.dnsResolve(domain)
			if IPHost == 0:
				#print "<DNSFail>"
				return "127.0.0.4"
			
		#db.sqlsetdomain(domain, IPHost) # Add IP in database
		if IPHost <> 0 and IPHost <> '':
			self.addToCache(ipclient, domain, IPHost)
		#print "<Normal resolved>"
		return IPHost



class SQLConnexion:
	def __init__(self, dbhost, dbport, dbuser, dbpasswd, dbname, dbtable):

		time.sleep(5)
		self.db = MySQLdb.connect(host=dbhost, port=dbport, user=dbuser, passwd=dbpasswd, db=dbname)
		self.cur = self.db.cursor()
		self.tablecache = dbtable 
		try:
			time.sleep(5)
			self.db = MySQLdb.connect(host=dbhost, port=dbport, user=dbuser, passwd=dbpasswd, db=dbname)
			self.cur = self.db.cursor()
			self.tablecache = dbtable    
		except:
			print "Error connexion database MySQL"
			sys.stdout.flush()
			time.sleep(5)
			sys.exit(0)

	def close(self):
		self.cur.close()
		self.db.close()

	def sqlquery(self, query):
		try:
			self.cur.execute(query)
		except MySQLdb.Error, e:
			print "Error %d: %s" % (e.args[0], e.args[1])
			print "Query SQL \n %s" % query
			sys.stdout.flush()
			self.db.rollback()
			time.sleep(5)

	def sqlgetdomain(self, domain):
		res = 0
		self.sqlquery("SELECT * FROM `"+self.tablecache+"` WHERE `domain` = '"+domain[:-1]+"';")
		resultcount = int(self.cur.rowcount)
		if resultcount > 0:
			q = self.cur.fetchall()
			ip = q[0][1]
			banned = q[0][2]
			if banned == 1:
				res = "127.0.0.5"
			else:
				res = ip
		return res

	def sqlsetdomain(self, domain, ip):
		self.sqlquery("DELETE FROM `"+self.tablecache+"` WHERE `domain` = '"+domain[:-1]+"';")
		self.db.commit()
		self.sqlquery("INSERT INTO `"+self.tablecache+"` (`domain` ,`ip` ,`banned`) VALUES ('"+domain[:-1]+"', '"+ip+"', '0');")
		self.db.commit()

	def sqlgetcountry(self, ip):
		self.sqlquery("SELECT country FROM ip2nation WHERE ip < INET_ATON('"+ip+"') ORDER BY ip DESC LIMIT 0,1;")
		resultcount = int(self.cur.rowcount)
		if resultcount > 0:
			q = self.cur.fetchall()
			country = q[0][0]
			return country
		else:
			return "unkown"

	def sqlgetcountryname(self, ip):
		self.sqlquery("SELECT c.country FROM ip2nationCountries c, ip2nation i WHERE i.ip < INET_ATON('"+ip+"') AND  c.code = i.country ORDER BY i.ip DESC LIMIT 0,1;")
		resultcount = int(self.cur.rowcount)
		if resultcount > 0:
			q = self.cur.fetchall()
			country = q[0][0]
			return country
		else:
			return "unkown"

def serveClient(data, addr):
	#data, addr = req # recieve UDP data (usually on port 53)
	dnss = DNSQuery(data) # Parse DNS query
	
	isArpa = ".in-addr.arpa" in dnss.domain
	country = 'unkown'
	answer = '127.0.0.6'
	if isArpa:
		#print 'isArpa'
		ip = dnss.domain.split(".") 
		answer = ip[3]+"."+ip[2]+"."+ip[1]+"."+ip[0]
		#country = db.sqlgetcountry(answer)
		#countryname = db.sqlgetcountryname(answer)
		#if country in config_banned_countries:
		#answer = answer+"."+country+"."+countryname
		#TEST
		#answer = '127.0.0.1'
		#print "arpa adress"
	else:
		#print "normal domain"
		
		if config_cache_sql == 1: # if domain exists
			#UPDATE d'adresse deja existante
			#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server
			#db.sqlsetdomain(dnss.domain, answer) # Add IP in database
			answer = db.sqlgetdomain(dnss.domain) # Check if domain exists in database
			countryname = db.sqlgetcountryname(answer)
			country = db.sqlgetcountry(answer)
			if country in config_banned_countries and addr[0] == '8.8.8.20':
				answer = '127.0.0.7'

			udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user

		else: # if it's a new domain
			#print "New domain:"
			answer = dnss.resolveDomain(dnss.domain, 2, dnss, addr[0]) # Ask the Primary DNS server
			#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server
			if answer == 0 :
				answer = "127.0.0.8"
			else:
				#db.sqlsetdomain(dnss.domain, answer) # Add IP in database
				#countryname = db.sqlgetcountryname(answer)
				#country = db.sqlgetcountry(answer)

				#if country in config_banned_countries and addr[0] == '8.8.8.20':
				#	answer = '127.0.0.1'

				udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user

	# Display log
	heure = time.strftime('%d.%m.%y; %H:%M:%S',time.localtime())

	
	#if answer == '127.0.0.1':
	#	countryname = ''
	#	country = 'local'
	#else:
	#if answer != '127.0.0.1':
	#	db.sqlsetdomain(dnss.domain, answer) # Add IP in database
	if isArpa == False and config_display == True:
		print '%s; %s; %s; %s; %s;EOL;' % (heure, config_dnsip, addr[0], answer, dnss.domain)
	sys.stdout.flush()

	
def waitClients():
	try:
		while 1:
			req = udps.recieveQuery() # recieve UDP data (usually on port 53)
			if not req:
				continue
			#serveClient(req)
			#t = threading.Thread(target=serveClient, args=(req, conn, address))
			t = threading.Thread(target=serveClient, args=(req))
			t.daemon = True
			t.start()
	except KeyboardInterrupt:
		udps.close()


if __name__ == '__main__':
	print 'Started '+config_dnsip+';EOL;'
	sys.stdout.flush()
	if config_cache_sql == 1:
		db = SQLConnexion(config_dbhost, config_dbport, config_dbuser, config_dbpasswd, config_dbname, config_dbtable) # SQL Connexion
	dnsc = DNSClient(config_dnsrelay, config_dnstimeout) # DNS Client
	udps = DNSServer(config_dnsip, config_dnsport, config_delayerror) # DNS Server
	waitClients()


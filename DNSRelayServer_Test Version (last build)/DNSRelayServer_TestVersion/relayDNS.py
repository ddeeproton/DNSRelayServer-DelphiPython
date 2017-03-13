#!/usr/bin/env python
import sys, subprocess
import socket
import dns.resolver
from dns.exception import DNSException
import time
import sys

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

# Server DNS
config_dnsip = '0.0.0.0'
if len(sys.argv) > 1:
	if sys.argv[1] == 'config_dnsip':
		if len(sys.argv) > 2:
			config_dnsip = sys.argv[2]
			
# hostfile = 'hosts '+config_dnsip+'.txt'
hostfile = 'hosts.txt'
if len(sys.argv) > 3:
	if sys.argv[3] == 'hostfile':
		if len(sys.argv) > 2:
			hostfile = sys.argv[4]

config_dnsport = 53
config_delayerror = 1

config_display = True

# Banned countries
#config_banned_countries = ['us','uk','il','ie']
#config_banned_countries = ['il']
config_banned_countries = []

cache_domains = []
cache_ips = []

#=============================
# SQL
#=============================




class DNSClient:
	def __init__(self, nameservers, timeout):
		self.res = dns.resolver.Resolver()
		self.res.nameservers = nameservers
		self.res.timeout = timeout

	def dnsResolve(self, domain):
		res = 0
		try:
			answer = self.res.query(domain, "A")
			res = "%s" % answer[0]
		except dns.resolver.NoAnswer:
			print "Error: No AAAA record for", dnss.domain," ", data
			sys.stdout.flush()
		except dns.resolver.NXDOMAIN:
			print "Error: The name ", dnss.domain, " does not exist"
			sys.stdout.flush()
		except DNSException:
			print 'Error: DNS Exception: ', dnss.domain
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
			print "Error: recieving data on UDP server"
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

	def checkHost(self, domain):
		domain = domain[:-1]
		res = '';
		#fp = open('C:\WINDOWS\system32\drivers\etc\hosts', 'r')
		fp = open(hostfile, 'r')
		#fp = open('/mnt/sdcard2/!prog/hosts', 'r')
		for line in fp.readlines():
			#print line
			if "	"+domain in line:
				res = line.split("	")[0]
			if " "+domain in line:
				res = line.split("	")[0]
		fp.close()
		if res <> "":
			if res[0] == "#":
				res = '';
		return res

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


	def resolveDomain(self, domain, idstatus):
	
		if config_cache_memory == 1:
			if domain in cache_domains:
				i = cache_domains.index(domain)
				return cache_ips[i]
			else:
				cache_domains.append(domain)
				
		if ".in-addr.arpa" in domain:
			if config_display:
				print "ARPA"
			if config_cache_memory == 1:
				cache_ips.append("127.0.0.1")
			return "127.0.0.1"
			
		IPHost = dnss.checkHost(domain)
		if IPHost <> '':
			if config_display:
				print "Host file domain:"
			if config_cache_memory == 1:
				cache_ips.append(IPHost)
			return IPHost


			
		d = dnss.onlyDomain(domain)
		#print d
		nameservers = config_dnsrelay
		ip = dnsc.dnsResolve(domain) # Ask the Primary DNS server
		if ip == 0:
			if config_cache_memory == 1:
				cache_ips.append("127.0.0.1")
			return "127.0.0.1"
			
		#db.sqlsetdomain(domain, ip) # Add IP in database
		if config_cache_memory == 1:
			cache_ips.append(ip)
		return ip

		

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
				res = "127.0.0.1"
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

if __name__ == '__main__':
	print 'Started;EOL;'
	sys.stdout.flush()
	if config_cache_sql == 1:
                db = SQLConnexion(config_dbhost, config_dbport, config_dbuser, config_dbpasswd, config_dbname, config_dbtable) # SQL Connexion
	dnsc = DNSClient(config_dnsrelay, config_dnstimeout) # DNS Client
	udps = DNSServer(config_dnsip, config_dnsport, config_delayerror) # DNS Server
	
	try:
		while 1:
			req = udps.recieveQuery() # recieve UDP data (usually on port 53)
			if not req:
				continue
			data, addr = req # recieve UDP data (usually on port 53)
			dnss = DNSQuery(data) # Parse DNS query
			
			isArpa = ".in-addr.arpa" in dnss.domain
			country = 'unkown'
			answer = '127.0.0.1'
			if isArpa:
				print 'isArpa'
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
						answer = '127.0.0.1'

					udps.sendQuery(dnss.dnsAnswer(answer), addr) # Send IP to the user

				else: # if it's a new domain
					#print "New domain:"
					answer = dnss.resolveDomain(dnss.domain, 2) # Ask the Primary DNS server
					#answer = dnsc.dnsResolve(dnss.domain) # Ask the Primary DNS server
					if answer == 0 :
						answer = "127.0.0.1"
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
			print '%s; %s; %s; %s;EOL;' % (heure, addr[0], answer, dnss.domain)
			sys.stdout.flush()
	except KeyboardInterrupt:
		udps.close()


![](preview.png)


# DNS Relay Server

### T�l�charger le setup d'installation Windows:

https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/Setup%20installation/DNSRelayServerSetup_0.4.380.exe

### T�l�charger les codes sources:

https://github.com/ddeeproton/DNSRelayServer-DelphiPython/raw/master/Sources

### Bug

Pour que le filtrage DNS puisse fonctionner, d�sactivez l'IPv6 dans les param�tres de vos cartes r�seau (voir image).

![](bug.png)

### Description:

"DNS Relay Server" est une application qui a pour but d'offrir un filrage sur les DNS.

L'id�e est de proposer un firewall (un parfeu) sur la couche DNS.

### "DNS Relay Server" peut servir �:
-Bloquer les publicit�s

-Savoir ce que fait une machine sur Internet

-Contr�ler s'il n'y a pas de virus / malware qui tente de communiquer.

-De bloquer les mises � jours obligatoires (dont certains sont normalement impossible � bloquer).

-De poser un filtrage parentale

-Acc�l�rer votre connexion Internet (en gardant en cache les requ�tes DNS)

-De moins soliciter le serveur DNS de votre FAI (gr�ce au cache) donc aspect "�cologie" et "vie priv�e".

-De rajouter des noms de domaines � des IP d'un seul coup pour plusieurs machines (clients DNS). 

-De vous avertir en cas de d�connexion d'internet

-et bien d'autre choses auquel je n'ai pas pens� ^^

### Avertissement:
Les versions 0.x signifient que vous �tes sur une version b�ta. Ce qui signifie qu'il peut y avoir des bugs et des fonctionnalit�s non-impl�ment�es.  

Ce prorgamme est gratuit et le restera toujours. 


### T�l�charger le code source:

https://github.com/ddeeproton/DNSRelayServer-DelphiPython/archive/master.zip


### Compilation:

Compile avec:

-Delphi 7 

T�l�chargez gratuitement Delphi 7 ici et si n�cessaire, executez en mode admin le setup d'installation (Windows vous dira peut-�tre qu'il n'est pas compatible, mais �a marche quand-m�me). 

https://delphi.developpez.com/telecharger-gratuit/delphi7-perso/


-Ne compile pas avec: 

Delphi 6



### Nouveaut�s :

Version 0.4.343 Ajout de Netstat:

![](preview2.png)

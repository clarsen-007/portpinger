<HTML>
  <BODY>
    <PRE>
      # portpinger
Is a IPv4 port Open or Closed?

This is a Linux BASH script.

Usage: portpinger.sh [ -s URL or IP address ] [ -p port ] 
                     [ -t protocol ( default TCP ) ] UDP is stateless and unreliable for ping requests 
                     [ -c count, number of pings ( default is 5 ) ] 
                     [ -d set timeout for ping TTL in seconds ( default is 5 seconds ) ] 
                     [ -h display help text and exit ] 
                     [ -v display version text and exit ] 

           Example... 

               portpinger.sh -s www.google.com -p 80 -t tcp -c 2

Please use freely and modify as required, at your own risk...
    </PRE>
  </BODY>
</HTML>

<HTML>
  <BODY>
    <pre>
# portpinger
IS a IPv4 port Open or Closed

This is a Linux BASH script.

Example:

./portpinger.sh www.google.com 80 tcp 2

"Pings" URL www.google.com PORT 80 TYPE tcp NUMBER OFF PINGS 2...

Example output:

$ ./portpinger.sh www.google.com 80 tcp 2
Count 1 Port 80 is Open Delay time 0.146 ms
Count 2 Port 80 is Open Delay time 0.037 ms

$ ./portpinger.sh www.google.com 22 tcp 2
Count 1 Port 22 is Closed Delay time 31.613 ms
Count 2 Port 22 is Closed Delay time 31.751 ms


Please use freely and modify as required...

    </pre>
  </BODY>
</HTML>

#!/usr/bin/env python

"""
Port Ping utility
"""

from __future__ import print_function

import argparse
import sys
import socket
import time
import signal
from timeit import default_timer as timer

# Pass/Fail counters
passed = 0
failed = 0
count = 0


def main(cmdline=None):

    """
    The main function. This takes the command line arguments provided, parsers them,
    build the message that needs to be send and then sends the actual test message.
    """

    parser = make_parser()

    args = parser.parse_args(cmdline)

    signal.signal(signal.SIGINT, signal_handler)

    ping_tcp_port(args.server, args.port, args.delay)

    return 0


def ping_tcp_port(server, port, delay):

    """
    This function does the actual pinging of the TCP port
    """

    global count
    global passed
    global failed

    while True:
        count += 1

        success = False

        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # 1sec Timeout
        s.settimeout(1)

        # Start a timer
        s_start = timer()

        # Try to Connect
        try:
            s.connect((server, int(port)))
            s.shutdown(socket.SHUT_RD)
            success = True

        # Connection Timed Out
        except socket.timeout:
            print("Port is closed!!!")
            failed += 1
        except OSError as e:
            print("OS Error:", e)
            failed += 1

        # Stop Timer
        s_stop = timer()
        s_runtime = "%.2f" % (1000 * (s_stop - s_start))

        if success:
            print("Connected to %s[%s]: tcp_seq=%s time=%s ms" % (server, port, (count-1), s_runtime))
            passed += 1

        # Sleep for 1sec
        time.sleep(delay)


def getResults():
    """ Summarize Results """

    global count
    global passed
    global failed

    lRate = 0
    if failed != 0:
        lRate = failed / (count) * 100
        lRate = "%.2f" % lRate

    print("\nPortPinger Results: Connections (Total/Pass/Fail): [{:}/{:}/{:}] (Failed: {:}%)".format((count), passed, failed, str(lRate)))


def signal_handler(signal, frame):
    """ Catch Ctrl-C and Exit """
    getResults()
    sys.exit(0)


def make_parser():

    """
    This function builds up the command line parser that is used by the script.
    """

    parser = argparse.ArgumentParser(description='TCP Port Ping')

    parser.add_argument('-s', '--server', type=str, help='Server Name', required=True)
    parser.add_argument('-p', '--port', type=int, help='Port number', default=80)
    parser.add_argument('-d', '--delay', type=int, help='Delay', default=1)
    return parser


if __name__ == "__main__":


    sys.exit(main(sys.argv[1:]))

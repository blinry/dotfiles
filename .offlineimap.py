#! /usr/bin/env python2
from subprocess import check_output


def get_pass(account):
    return check_output("gopass " + account, shell=True).splitlines()[0]

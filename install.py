#/usr/bin/env python
import sys, os
import configparser as cfg


PLATFORM = sys.platform # one of
# Linux (2.x and 3.x)	'linux2'
# Windows	'win32'
# Windows/Cygwin	'cygwin'
# Mac OS X	'darwin'
VERBOSE = False
TEST = False

def get_apps():
    """Returns all the directories at the same level as install.py"""
    pass

def install_app(app):
    pass
    
def link(source, target):
    """
    Creates a link from source to target.
    
    Is aware of operating system."""
    if os.name == 'posix':
        # use
        os.link(source, target)
    elif PLATFORM == 'win32':
        # use mklink
        pass


if __name__ == '__main__':
    args = sys.argv[1:]
    VERBOSE = ('--verbose' in args) or ('-v' in args)
    TEST = ('--test' in args) or ('-t' in args)
    
    for app in get_apps():
        install_app(app)
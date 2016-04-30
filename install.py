#/usr/bin/env python
import sys, os
try :
    import configparser as cfg
except ImportError:
    import ConfigParser as cfg

PLATFORM = sys.platform # one of
# Linux (2.x and 3.x)	'linux2'
# Windows	'win32'
# Windows/Cygwin	'cygwin'
# Mac OS X	'darwin'
VERBOSE = False
TEST = False
UPDATE = False

SOURCE_DIR = os.path.dirname(os.path.abspath(__file__))
TARGET_DIR = os.path.expanduser("~") 

def get_apps():
    """Returns all 'apps', that is all the directories at the same level as install.py"""
    apps = []
    for potential in os.listdir(SOURCE_DIR):
        if not os.path.isdir(potential): continue
        if potential.startswith('.'): continue
        # TODO: ignore if it has a .exclude file
        yield potential

def install_app(app):
    print("Installing %s..." % (app, ))
    
def link(source, target):
    """Creates a link from source to target.
    
    Is aware of operating system."""
    if os.name == 'posix':
        # use
        if (VERBOSE) :
            print("Linking: %s => %s" % (source, target))
        # os.link(source, target)
    elif PLATFORM == 'win32':
        # use mklink
        mklink_dir_flag = "/d" if os.path.isdir(source) else ""
        if (VERBOSE) :
            print("mklink %s %s %s", (mklink_dir_flag, target, source))


if __name__ == '__main__':
    args = sys.argv[1:]
    VERBOSE = ('--verbose' in args) or ('-v' in args)
    TEST = ('--test' in args) or ('-t' in args)
    UPDATE = ('--update' in args) or ('-u' in args) or ('update' in args)
    usage = ('--help' in args) or ('-h' in args) or ('/?' in args)
    
    if usage:
        print("""
python install.py [OPTIONS]

OPTIONS:
  -v
  --verbose  - Details all the steps it takes.
  -t
  --test     - Does not actually perform any operation, only pretends.
  -u
  --update   - UPDATE MODE, two-way update of .dotfiles

UPDATE MODE:
Update mode will attempt to pull the remote branch, 
merge it into current and if successful, will also 
attempt to push your local changes to remote.
        """)
    else:
        for app in get_apps():
            install_app(app)
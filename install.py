#/usr/bin/env python
import sys, os, shutil
import datetime as dt
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
        yield potential

def install_app(app):
    """Analyses configuration and creates links"""
    app_path = os.path.join(SOURCE_DIR, app)
    if os.path.exists(os.path.join(app_path, '.exclude')): 
        print("Excluding %s..." % app)
        return
    print("Installing %s..." % app)
    has_instructions = False
    if os.path.exists(os.path.join(app_path, '.dot')):
        link(app_path, os.path.join(TARGET_DIR, '.%s' % app))
        has_instructions = True
    
    for dot_something in os.listdir(app_path):
        if dot_something.startswith('.dot-'):
            the_something = dot_something[5:]
            link(app_path, os.path.join(TARGET_DIR, the_something))
            has_instructions = True
            
    if os.path.exists(os.path.join(app_path, '_install.cfg')):
        if VERBOSE:
            print "Installing according to config file."
        has_instructions = True
    # install all app files into root
    if not has_instructions:
        for f in os.listdir(app_path):
            link(os.path.join(app_path, f), os.path.join(TARGET_DIR, f))

        
def link(source, target):
    """Creates a link from source to target.
    
    Is aware of operating system."""
    if os.path.exists(target):
        backup = "%s-%s.bak" % (target, dt.datetime.today().strftime("%Y%m%d%H%M%S"))
        if VERBOSE:
            print("%s already exists. Backing up to %s." % (target, backup))
        
    if os.name == 'posix':
        # use
        if VERBOSE :
            print("Linking: %s => %s." % (source, target))
        # os.link(source, target)
    elif PLATFORM == 'win32':
        # use mklink
        mklink_dir_flag = "/d" if os.path.isdir(source) else ""
        if VERBOSE :
            print("mklink %s %s %s.", (mklink_dir_flag, target, source))


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
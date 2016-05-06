[[ -d /opt/plan9 ]] && export PLAN9=/opt/plan9
[[ -d /usr/lib/plan9 ]] && export PLAN9=/usr/lib/plan9
[[ -d /usr/local/plan9 ]] && export PLAN9=/usr/local/plan9

if [[ -d $PLAN9 ]]; then
   export NAMESPACE=/tmp/ns.$USER.`hostname`
   export PATH=$PATH:$PLAN9/bin

   [[ ! -d $NAMESPACE ]] && mkdir $NAMESPACE
fi

# Some installations don't include plumber...
if [[ -e $PLAN9/bin/plumber ]]; then
   9p read plumb/rules >/dev/null 2>/dev/null
   [[ $? -ne 0 ]] && plumber 2>/dev/null

   # first rule wins, so make sure files are named in proper order
   cat $ZPLUG_HOME/repos/gchpaco/plan9-zsh/*.plumbing $PLAN9/plumb/initial.plumbing | 9p write plumb/rules >/dev/null
fi


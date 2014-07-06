if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31;40'

# MacPorts Installer addition on 2014-03-03_at_22:03:35: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

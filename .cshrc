#: standard .cshrc
#: 18 June 1993

#::::
#: The following .cshrc was written for customization.  When the comments
#: (the English text marked off with "#:", such as this) say "comment"
#: something, it means place a "#" (and some white space, if you like) at
#: the beginning of the line.  Uncomment means remove the "#" and the
#: white space.

#: Obviously, all permutations of options below could not be tested on
#: all machines.  If you discover a problem, or have suggestions for
#: adding functionality to this script, mail problem.
#::::

#: The name of this machine and the OS; don't change these lines.
#set hw_os=`/home/carden/bin/hw_os`

#: The following is where the shell will look when you issue the "cd"
#: command, if it doesn't find the argument in the current directory.
#: The tilde (~) stands for your home directory.  Add more paths that
#: contain directories you often cd to, and you won't have to give the


set cdpath = ( ~ ~/ps )

#: The following is where the shell will look for commands you type.  You
#: can type "which <command>" to find out the location of a command,
#: provided its file is in one of these directories and is executable
#: (has the x permission set).  You may want to add some directories
#: here.  Note the first and second elements.  These set your ~/bin
#: directory as the very first place to look for commands, and a
#: hardware-dependant home bin directory as the second place.  Placing
#: commands or links in these directories, you can override commands
#: that would ordinarily be executed.  bin-$hw_os is also a good place
#: to put binaries, since they aren't compatible across architectures.

#set path = (${home}/bin-${hw_os} ${home}/bin /usr/local/etc /usr/local/bin /usr/ucb /usr/openwin/bin /usr/afsws/bin /usr/afsws/etc /usr/X11R6/bin /usr/local/bin/X11R5 /usr/bin /bin /etc /usr/etc /usr/sbin /usr/bin/X11/sbin /usr/ccs/bin /usr/etc/appletalk /usr/local/contrib/moderated/bin ${home} /usr/local/contrib/bin ${home}/ps/tf /afs/unc/pkg/httpd/1.5.1/support /usr/games /sbin .)


set path = ( ${home}/bin /opt/SUNWspro/bin /usr/local/etc /usr/local/bin /usr/bin /bin /etc /usr/bin/X11 /usr/X11/bin /usr/etc /usr/sbin /usr/ccs/bin /sbin /usr/bsd /usr/openwin/bin /usr/ucb . )
set host = `hostname | cut -d. -f1`
setenv HOST $host


#: Command-line history allows you to recall comands you previously typed
#: and run them again, by typing a !n, where n is the number of the
#: command (shown in your prompt).  If you're using tcsh, you can also
#: back up with the arrow keys, and even edit the recalled commands on
#: the command line.  The follwing number can be changed so that the
#: shell saves more or less than 50 of your previous commands.  Don't go
#: too high or things will get slow.

set history = 50		

# The following line sets the default file and directory permissions.
# In /afs/*, these may not have the desired effect; consult your AFS
# documentation.  Under NFS/UFS, a umask 022 makes new files be created
# with permissions 644 (owner has read/write permission and group and
# other have read permission only) and directories get permissions 755
# (read/write/execute for owner and read/execute for group and other).
# See man umask(1) for more info.
umask 022

# Limit the size of core dumps to 0.  If you are programming and need to
# use core dumps, this limit can be turned off by commenting this line
# or by executing "unlimit coredumpsize" at the command line.  It doesn't
# work on Hewlett-Packard machines, so we don't set it if on an HP.
#if ($hw_os != 'hp700_hpux') limit coredumpsize 0

#: Your command-line prompt.  You can change this to whatever you like.
#: Below, it prints something like:
#:    machine(n)% 
#: where machine is the name of the machine you're using, and n is the
#: number of the current command (see the description of command-line
#: history above).  If you're using tcsh, you may want to check out
#: section 12 of the tcsh(1) manual page; tcsh allows you to put things
#: like the current time, boldfacing and highlighting, and other neat
#: stuff in the prompt.

setenv GIT_BRANCH_CMD "sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'"
set whoami=`whoami`
if ($whoami == root) then
	set prompt = "$whoami\@%m(\!) %c2%# "
else
	if ($?prompt) then
#	set prompt = "$whoami\@%m(\!) %c2%# "
    alias precmd "source ~/.gitprompt.csh"
	endif
endif

#: The following three aliases are a local modification to the tried and
#: true commands.  The -t option means that commands deleted by rm, mv,
#: or cp are saved in the .trash directory in your home directory.  This
#: directory gets cleared out automatically every twenty-four hours.  I
#: wouldn't change these, either, and if you do, make sure you leave the
#: -t option!

set whoami=`whoami`
if ($whoami != carden) then
if (-e /usr/local/bin/cpscript) then
    	alias cp /usr/local/bin/cpscript
else
	unalias cp
endif
if (-e /usr/local/bin/mvscript) then
	alias mv /usr/local/bin/mvscript
else
	unalias mv
endif
if (-e /usr/local/bin/rmscript) then
	alias rm /usr/local/bin/rmscript
else
	unalias rm
endif
#source ~carden/.aliases
endif

#: The following enhances 'ls' to show a * after names of executables, /
#: after directories, @ after links, and so forth.  The second option,
#: which you can uncomment if you like (after commenting the first, of
#: course) will make ls also show files that start with dots (.).

alias ls ls -F
#alias ls ls -Fa

#: The following are some possible changes you might like to make to the
#: 'cd' command.  Uncomment any one of them (but only one) to make it
#: active.  The first makes cd print your new working directory whenever
#: you cd.  The second prints your new working directory and then
#: performs an ls.

alias cd "cd \!* ; pwd"
# alias cd "cd \!* ; pwd ; ls"

#: If you post to news, without the following set, the From: line will
#: read "login@machine.cs.unc.edu" where login is your login and machine
#: is the machine you posted from.  The following will change it to
#: "login@cs.unc.edu".

setenv FROM cs.unc.edu

#: Do you want to be able to be contacted if people call you with the
#: 'talk' command?  If so, change the n below to a y.

#if ( $?tty ) mesg n

#: The following keeps you from deleting (or 'clobbering') a file by
#: using file redirection (>) accidentally.  It also makes sure that
#: append redirection (>>) refers to an existing file.  Comment this out
#: if you want to be able to kill and create files this way.

#set noclobber

#: Do you ever hit the control-d key accidentally and log yourself out?
#: Uncomment the next line, and control-d will no longer log you out.  We
#: meanwhile add the shorter, more friendly 'bye' as a new way to exit
#: shells.

# set ignoreeof
alias bye exit

#: If the following is uncommented, background jobs (commands that you
#: ended with an &) will tell you immediately when they're done, whether
#: you're running another program or not.  Left commented, it'll wait
#: until the next prompt before informing you.

# set notify

#: You can get the shell to save your history buffer between login
#: sessions.  If you want to enable this feature, uncomment the following
#: line.  The number is the number of saved commands in the history;
#: change it if you want.

# set savehist=50

#: What pager do you like?  If you use less, put it here in place of more.

setenv PAGER more

#: And what editor?  You can put emacs here rather than vi, if you
#: like, and applications that call vi will call emacs instead.

setenv EDITOR vi

#: Now some things that specific machines need.  Don't worry about what
#: it does.  I wouldn't touch it, it'll break!

#switch ($hw_os)
#       case hp700_hpux:
#               alias df bdf
#               alias resize eval \`/usr/local/bin/X11R5/resize\`
#               set my_tty=`tty`
#               if ("$my_tty" != "not a tty") then
#                       if ($?term) then
#                               if ($term == xterm) then
#                                       eval `/usr/local/bin/X11R5/resize`
#                               endif
#                       endif
#               endif
#	       set user = $USER
#               unset autologout
#               breaksw
#	case ibm_aix:
#		set my_tty = `tty`
#		if ("$my_tty" != "not a tty") then
#			stty echoe
#		endif
#		unalias rm
#		unalias mv
#		unalias cp
#		breaksw
#	case sgi_irix:
#		unalias rm
#		unalias mv
#		unalias cp
#		breaksw
#	case sparc_solaris:
#		unalias rm
#		unalias mv
#		unalias cp
#		breaksw
#	case i686_linux:
#		unalias rm
#		unalias mv
#		unalias cp
#		breaksw
#endsw
		unalias rm
		unalias mv
		unalias cp



#: The following value has two parts.  The first is a number which is the
#: number of seconds the shell waits before checking to see if you have
#: mail in the file in the second part.  If you have mail, it will print
#: "You have new mail." after the next command you run.  You can change
#: this number.  I wouldn't change the filename.

#if ($hw_os == 'pc_linux') then
#        setenv LD_LIBRARY_PATH /usr/local/bin/rvplayer5.0:/usr/lib:/lib:/usr/i486-linux-libc5/lib:/usr/X11R6/lib:/usr/openwin/lib
#        setenv MANPATH /usr/share/man:/usr/local/bin:/usr/man:/usr/afsws/man:/usr/local/contrib/moderated/man:/usr/share/catman:/usr/X11R6/man
#else
#        setenv LD_LIBRARY_PATH /usr/openwin/lib:/usr/lib:/usr/local/lib/X11:/usr/dt/lib
#	setenv MANPATH /net/solaris-man/usr/share/man:/opt/SUNWspro/man:/usr/man:/usr/local/man:/usr/afsws/man:/usr/local/contrib/moderated/man:/usr/share/catman:/usr/openwin/man
#endif
        setenv LD_LIBRARY_PATH /usr/local/bin/rvplayer5.0:/usr/lib:/lib:/usr/i486-linux-libc5/lib:/usr/X11R6/lib:/usr/openwin/lib
        setenv MANPATH /usr/share/man:/usr/local/bin:/usr/man:/usr/afsws/man:/usr/local/contrib/moderated/man:/usr/share/catman:/usr/X11R6/man




set mail= (600 /usr/spool/mail/$user)

#: You can add your own aliases and settings in the file ~/.aliases.
if (-e ${HOME}/.aliases) source ~/.aliases 
if (-e ${HOME}/.auxcshrc ) source ~/.auxcshrc

#if (-e /projects/opt/.auxcshrc ) source /projects/opt/.auxcshrc


#if (-e /projects/opt/.auxcshrc) source /projects/opt/.auxcshrc
#newgrp res fbudin
##TARHEEL6 OPEN GL issue on servers
setenv LIBGL_ALWAYS_INDIRECT 1

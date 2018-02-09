# vim: set filetype=shell
# some more ls aliases
alias ll='ls -alF'
alias lla='ls -a'
#alias l='ls -CF'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias act='[ -d env ] && source env/bin/activate || echo "No environment directory found here"'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Reload bashrc; best when editing .bashrc
alias reload='reset; source ~/.bashrc'
alias reloads='source ~/.bashrc &> /dev/null'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'

## App-specific aliases
alias wget='wget -c'
alias trash='mv -t ~/.local/share/Trash/files'
alias less='less -R'

#show most popular commands
alias top-commands='history | awk "{print $2}" | awk "{print $1}" |sort|uniq -c | sort -rn | head -10'
#alias top-commands='history | awk "{print $2}" | awk "BEGIN {FS="|"} {print $1}" |sort|uniq -c | sort -rn | head -10'


### Alphabatical
alias a='aria2c -c -x 16'
# alias ack='ack-grep'
alias aria2cm='aria2c -c -x 16'
#alias acki='ack --ignore-dir=build'
alias acki='ack --ignore-dir=build --ignore-dir=doc'

alias c='pygmentize -g'
alias cats='highlight -O ansi'
#alias cdw ^defined above
alias catlatest='cat `ls -t|head -1`'
alias cd..='cd ..'
alias ctop='sudo docker run --rm -it --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'

alias d='date'
alias df='df -h'
alias dfh='df -h'
alias dfs='df -h | sort -n'
alias du='du -h -c'
alias dn='OPTIONS=$(\ls -F | grep /$); select s in $OPTIONS; do cd $PWD/$s; break;done'

alias g='git'
alias gbl='git blame -wMC'
alias gds='git diff --stat'
alias getbase='cp -pv ~/code/codpro/base.c ~/code/codpro/base.cpp ./'
alias gflff='git flow feature finish `git rev-parse --abbrev-ref HEAD | sed "s/feature\///"`'
alias gflfs='git flow feature start'
alias glof='git log --pretty=fuller --stat --decorate --graph --show-signature'
alias glm='git l --all'
alias grepi='grep -i'
alias gtop='git rev-parse --show-toplevel'
alias gw='./gradlew '

alias idea='bash -c "~/Documents/idea-IC/bin/idea.sh &"'
alias ipy='ipython3'
alias ipy2='ipython2'
alias ipy3='ipython3'
alias j='jobs'
alias l='d; ls -ltrFhH'
alias lexa='d; exa -bghHlS -s modified --git'
alias la='d; ls -lAtrFhH'
alias li='logmein -i'
alias lip='watch -n 1 logmein -i'
alias lir='~/code/python/password_me/randomise_login.py'
alias lo='logmein -o'
alias lsize='ls --sort=size -lhr' # list by size
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size
alias lr='ls -lR'        # recursice ls
alias lsd='ls -l | grep "^d"'   #list only directories

# some more ls aliases
#alias ls='ls -hF --color'    # add colors for filetype recognition
#alias la='ls -Al'        # show hidden files
#alias lt='ls -ltr'        # sort by date
#alias lm='ls -al | more'        # pipe through 'more'
#alias ll='ls -l'        # long listing
#alias l='ls -hF --color'    # quick listing

alias masquerade='sudo iptables -t nat -A POSTROUTING -o wlp3s0 -s 192.168.1.0/24 -j MASQUERADE'
alias mkdirs='temp_c() {mkdir $1; cd $1}; temp_c'
alias myhistory='cat ~/bashbackup.txt'
alias nf='ls | wc -l'

alias p='pwd'
alias pms='sudo supervisorctl'
alias proxy='cat -n /etc/apt/apt.conf'
#alias proxyNone='sudo sh -c \'echo -n "" > /etc/apt/apt.conf\''
alias proxyUiet='sudo cp /etc/apt/aptUiet.conf /etc/apt/apt.conf'
alias py='python3'
alias py2='python2'
alias py3='python3'
alias pyd='pydoc3'
alias pyl="PYTHONPATH='.' python3"
alias rm='rm -v'
alias serve='python3 -m http.server'
alias studio='bash -c "~/code/android/android-studio/bin/studio.sh &"'
#alias sublime='~/Documents/sublime_text_3/sublime_text'
#alias sublime='/opt/sublime_text/sublime_text'
# Cached version of ssh, uses the first connection for subsequent calls
alias sshc='ssh -o "controlmaster=auto" -o "controlpath=/tmp/ssh-$USER-%r@%h:%p"'
alias sshb='ssh -nNT -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -v -D'
alias sshba='autossh -M 0 -nNT -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -v -D'
alias sshbac='autossh -M 0 -nNTC -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -v -D'
alias sudoh='sudo -H'
#alias tree='tree -Csh'        # nice alternative to 'ls'
alias t='tree -Csh'        # nice alternative to 'ls'
alias tf="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias ta='tmux attach'
alias timev='/usr/bin/time -v'

#some variations
#alias vp='vim `ls -t *.@(pl|cgi)| head -1 `'
#alias vc='vim `ls -t *.@(c|cpp|h|py)| head -1 `'
alias vp='vim `ls -t *.@(py|pl|cgi)| head -1 `'
alias vc='vim `ls -t *.@(c|cpp|h)| head -1 `'
#When I know the file I want to edit is the most recent file in a directory
alias vew='vim `ls -t * | head -1 `'

alias watch='watch --color'
alias wcall='wc `ls -tr`'
alias wcl='wc -l'
alias wcld='for f in `ls`; do echo $f: `ls $f | wc -l`; done'
#execute the most recent script (I call this from within VIM with a mapped button)
#alias xew='`ls -t *.pl | head -1 `'
alias xew='xdg-open "`ls -t * | head -1 `"'
alias x='xdg-open'



## Keeping things organized
#alias rm='mv -t ~/.local/share/Trash/files'
#alias cp='cp -i'
#alias mv='mv -i'
#alias mkdir='mkdir -p -v'

#When I know the file I want to edit contains a unique keyword. This is actually in a little shell script call ed vg where the keyword is passed as parameter $1
#/bin/sh
#name vg
#vi.exe $(grep -isl $1 *) &

if [ -f ~/.dev_aliases.sh ]; then
    . ~/.dev_aliases.sh
fi

if [ -f ~/.temp_aliases ]; then
    . ~/.temp_aliases
fi

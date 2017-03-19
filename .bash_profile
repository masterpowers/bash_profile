# check if the user is Root if Yes Then Do the Following
if [[ $EUID = 0 ]]; then
alias uriah='cd /home/uriah'
fi

# All Function Aliases are applied to All Users
alias h='cd ~'
alias home='cd ~'
alias c='clear'

# Short Cut Directory
alias uriah='cd /home/uriah'
alias sites='cd /var/www/'
alias code='cd /var/www/reporthero.io'
alias laradock='cd /var/www/reporthero.io/laradock'
alias reloadsh='exec $SHELL -l'


# Listing Directory Shortcut
alias la='ls -Al'               # show hidden files
alias ls='ls -aF --color=always' # add colors and file type extensions
alias lx='ls -lXB'              # sort by extension
alias lz='ls -lSr'              # sort by size
alias lc='ls -lcr'      # sort by change time
alias lt='ls -lur'      # sort by access time
alias lr='ls -lR'               # recursive ls
alias ld='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'

# CD Shortcut
alias ..='cd ..'
alias ...='cd ../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'

# File and Folder Permission
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'
# System Info Short Cut
alias ps='ps auxf'
alias pg='ps aux | grep $*'  #requires an argument
alias mountedinfo='df -hT'
alias ping='ping -c 10'
alias du1='du -h --max-depth=1'
alias da='date "+%Y-%m-%d %A    %T %Z"'
alias c='clear'
alias hs='history | grep $1'


# File Shortcut
alias bashprofile='vim ~/.bash_profile'

# Laravel Shortcut
alias newapp='composer create-project laravel/laravel $1 --no-progress --profile --prefer-dist'
alias appname='php artisan app:name'
alias artisan='php artisan'
alias dump='php artisan dump'
alias migrate='php artisan migrate'
alias optimize='php artisan optimize'
alias serve='php artisan serve'
alias seed='php artisan db:seed'
alias tinker='php artisan tinker'
alias keygen='php artisan key:generate'

# Laravel Clear  Cache Commands
alias c1='php artisan cache:clear'
alias c2='php artisan view:clear'
alias c3='php artisan route:clear'
alias c4='php artisan config:clear'

# Laravel Test
alias t='vendor/bin/phpunit'
alias b='vendor/bin/behat'
alias b:init='vendor/bin/behat --init'
alias b:api='vendor/bin/behat -dl'
alias b:snip='vendor/bin/behat --append-snippets'
# Laravel Make Commands
alias mauth='php artisan make:auth'
alias mcmd='php artisan make:command'
alias mctrl='php artisan make:controller'
alias mevent='php artisan make:event'
alias mjob='php artisan make:job'
alias mlis='php artisan make:listener'
alias mmail='php artisan make:mail'
alias mmid='php artisan make:middleware'
alias mmig='php artisan make:migration'
alias mmod='php artisan make:model'
alias mnot='php artisan make:notification'
alias mpol='php artisan make:policy'
alias mpro='php artisan make:provider'
alias mreq='php artisan make:request'
alias mseed='php artisan make:seeder'
alias mtest='php artisan make:test'

# Laravel IDE Helper /PHPSTORM
alias ci_helper='composer require --dev barryvdh/laravel-ide-helper'
alias meta_helper='php artisan ide-helper:meta'
alias model_helper='php artisan ide-helper:models'


# Laravel Migrations
alias mi='php artisan migrate:install'
alias mr='php artisan migrate:refresh'
alias mrb='php artisan migrate:rollback'
alias ms='php artisan migrate:status'
# Laravel Routes
alias rc='php artisan route:cache'
alias rl='php artisan route:list'
alias rf='php artisan route:list | grep $*'

# Other Laravel Command Shortcut
alias cc='php artisan config:cache'
alias eg='php artisan event:generate'
alias sr='php artisan schedule:run'
alias sl='php artisan storage:link'
alias vp='php artisan vendor:publish'

# Laradock 
alias ldock:init='git submodule add https://github.com/LaraDock/laradock.git'

# Laravel Specific Functions

# Create A Tag For Your Project
function tagsInit()
{
 ctags -R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor;
 echo "tags file Created! type vim tags [keyword]";
 echo "shortcut inside vim tt=find tn=next tp=previous ts=list";
}

# List All Routes or Filter by Name
function routes()
{
    if [ $# -eq 0 ]; then
        php artisan route:list
    else
        php artisan route:list | ack ${1}
    fi
}
# Tail Laravel Logs
function logs () {
    tail -f storage/logs/laravel.log | awk '
                {matched=0}
                /INFO:/    {matched=1; print "\033[0;37m" $0 "\033[0m"}   # WHITE
                /NOTICE:/  {matched=1; print "\033[0;36m" $0 "\033[0m"}   # CYAN
                /WARNING:/ {matched=1; print "\033[0;34m" $0 "\033[0m"}   # BLUE
                /ERROR:/   {matched=1; print "\033[0;31m" $0 "\033[0m"}   # RED
                /ALERT:/   {matched=1; print "\033[0;35m" $0 "\033[0m"}   # PURPLE
                matched==0            {print "\033[0;33m" $0 "\033[0m"}   # YELLOW
        '
}

# File Management Section

# Pretty-print of some PATH variables:
alias envpath='echo -e ${PATH//:/\\n}'

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }


# Find Str in a Patter
# Usage : fstr DB_HOST '.env'
function fstr()
{
OPTIND=1
local mycase=""
local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
while getopts :it opt
    do
    case "$opt" in
    i) mycase="-i " ;;
    *) echo "$usage"; return ;;
    esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
    echo "$usage"
    return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more
}

# Handy Extract Program
function extract()      
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Make Dir and CD to it
function mcd ()
{
    mkdir -p $1
    cd $1
}

# Switch a File or Folder
function swap()
{
    if [ ! -z "$2" ] && [ -e "$1" ] && [ -e "$2" ] && ! [ "$1" -ef "$2" ] && (([ -f "$1" ] && [ -f "$2" ]) || ([ -d "$1" ] && [ -d "$2" ])) ; then
        tmp=$(mktemp -d $(dirname "$1")/XXXXXX)
        mv "$1" "$tmp" && mv "$2" "$1" &&  mv "$tmp"/"$1" "$2"
        rmdir "$tmp"
    else
        echo "Usage: swap file1 file2 or swap dir1 dir2"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

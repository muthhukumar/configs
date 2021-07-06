# Remove the default interactive shell message 
export BASH_SILENCE_DEPRECATION_WARNING=1

# Path export for android studio

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)


export WORKSPACE=$HOME/Desktop/workspace/


# Docker alias
############################################################################
#                                                                          #
#               ------- Useful Docker Aliases --------                     #
#                                                                          #
#     dc             : docker-compose                                      #
#     dcu            : docker-compose up -d                                #
#     dcd            : docker-compose down                                 #
#     dcr            : docker-compose run                                  #
#     dex <container>: execute a bash shell inside the RUNNING <container> #
#     di <container> : docker inspect <container>                          #
#     dim            : docker images                                       #
#     dip            : IP addresses of all running containers              #
#     dl <container> : docker logs -f <container>                          #
#     dnames         : names of all running containers                     #
#     dps            : docker ps                                           #
#     dpsa           : docker ps -a                                        #
#     drmc           : remove all exited containers                        #
#     drmid          : remove all dangling images                          #
#     drun <image>   : execute a bash shell in NEW container from <image>  #
#     dsr <container>: stop then remove <container>                        #
#                                                                          #
############################################################################

function dnames-fn {
        for ID in `docker ps | awk '{print $1}' | grep -v 'CONTAINER'`
        do
        docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
        done
}

function dip-fn {
    echo "IP addresses of all named running containers"

    for DOC in `dnames-fn`
    do
        IP=`docker inspect $DOC | grep -m3 IPAddress | cut -d '"' -f 4 | tr -d "\n"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo $OUT|column -t
}

function dex-fn {
        docker exec -it $1 ${2:-bash}
}

function di-fn {
        docker inspect $1
}

function dl-fn {
        docker logs -f $1
}

function drun-fn {
        docker run -it $1 $2
}

function dcr-fn {
        docker-compose run $@
}

function dsr-fn {
        docker stop $1;docker rm $1
}

function drmc-fn {
       docker rm $(docker ps --all -q -f status=exited)
}

function drmid-fn {
       imgs=$(docker images -q -f dangling=true)
       [ ! -z "$imgs" ] && docker rmi "$imgs" || echo "no dangling images."
}

# in order to do things like dex $(dlab label) sh
function dlab {
       docker ps --filter="label=$1" --format="{{.ID}}"
}

function dc-fn {
        docker-compose $*
}

# function d-aws-cli-fn {
#     docker run \
#            -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
#            -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
#            -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
#            amazon/aws-cli:latest $1 $2 $3
# }

# alias daws=d-aws-cli-fn
alias dc=dc-fn
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr=dcr-fn
alias dex=dex-fn
alias di=di-fn
alias dim="docker images"
alias dip=dip-fn
alias dl=dl-fn
alias dnames=dnames-fn
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drmc=drmc-fn
alias drmid=drmid-fn
alias drun=drun-fn
alias dsp="docker system prune --all"
alias dsr=dsr-fn
alias kctl=kubectl $*



# npm alias

alias nrd="npm run dev"
alias nrs="npm run start"
alias ni="npm install $*"
alias nrb="npm run build"
alias nrt="npm run test $*"
alias ns="npm start"




# PS1 show what need to be show before the command
PS1="$ "

alias personal="cd $WORKSPACE/personal"
alias deployment="cd $WORKSPACE/deployment"
alias epicreact="cd $WORKSPACE/personal/epicreact"

alias edit="vim $HOME/.bash_profile"


# Visual studio code alias
alias c="code ."



# React native alias
alias nri="npm run ios $*"
alias nra="npm run android $*"
alias nria="nri && nra"


export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

export PATH=$PATH:$HOME/Downloads/flutter/bin

export PATH
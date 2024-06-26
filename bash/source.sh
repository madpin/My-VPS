# Fix opening Code from Tmux
socket=$(ls -1t /run/user/$UID/vscode-ipc-*.sock 2> /dev/null | head -1)
export VSCODE_IPC_HOOK_CLI=${socket}

greeting () {
  echo "Hello $1"
  echo "Python path: $(which python)"
}

# poff () {
#     sudo poweroff
# }

svenv () {
    echo "########################### I'm in!!"
    subfolder=$1
    ssubfolder=$2
    arr=("venv" ".venv" ".env" "env")
    final="/bin/activate"
    
    for dir in ${arr[@]}; do
        if [ -d "${PWD}/$subfolder/$ssubfolder/$dir" ]; then
            # echo "${PWD}/$subfolder/$ssubfolder/$dir$final is our env now."
            source ${PWD}/$subfolder/$ssubfolder/$dir$final
            echo "Python path: $(which python)"
            echo "Pip path: $(which pip)"
            echo "###########################"
            return
        fi
    done

}

cvenv () {
    deactivate
    subfolder=$1
    ssubfolder=$2
    # python -m venv ${PWD}/$subfolder/venv
    # virtualenv --python="$(indeed-python)" ${PWD}/$subfolder/$ssubfolder/venv
    virtualenv ${PWD}/$subfolder/$ssubfolder/venv
    svenv $1 $2
}

ivenv () {
    subfolder=$1
    ssubfolder=$2
    files=("requirements.test" "requirements.dev" \
           "requirements.frozen" "requirements.base.frozen")
    
    for file in ${files[@]}; do
        if [ -f "${PWD}/$file" ]; then
            echo "Installing ${PWD}/$file"
            pip install -r ${PWD}/$file --quiet
        fi
    done

    for file in ${files[@]}; do
        if [ -f "${PWD}/$subfolder/$file" ]; then
            echo "Installing ${PWD}/$subfolder/$file"
            pip install -r ${PWD}/$subfolder/$file --quiet
        fi
    done

    for file in ${files[@]}; do
        if [ -f "${PWD}/$subfolder/$ssubfolder/$file" ]; then
            echo "Installing ${PWD}/$subfolder/$ssubfolder/$file"
            pip install -r ${PWD}/$subfolder/$ssubfolder/$file --quiet
        fi
    done
}

civenv () {
    cvenv $1 $2
    ivenv $1 $2
}

psync () {
    echo "Hello, pip-sync'ing now"
    subfolder=$1
    ssubfolder=$2
    files=("requirements.test" "requirements.dev" "requirements.frozen" "requirements.base.frozen")

    arr=()
    for file in ${files[@]}; do
        # If the file exists
        if [ -f "${PWD}/$file" ]; then
            arr+=("${PWD}/$file")
        fi
    done

    # If we have argument
    if [[ ! -z "$subfolder" ]]; then
        for file in ${files[@]}; do
            # If the file exists
            if [ -f "${PWD}/$subfolder/$file" ]; then
                arr+=("${PWD}/$subfolder/$file")
            fi
        done
    fi

    # If we have 2 arguments
    if [[ ! -z "$subfolder/$ssubfolder" ]]; then
        for file in ${files[@]}; do
            # If the file exists
            if [ -f "${PWD}/$subfolder/$ssubfolder/$file" ]; then
                arr+=("${PWD}/$subfolder/$ssubfolder/$file")
            fi
        done
    fi
    
    if [ ! ${#arr[@]} -eq 0 ]; then
        pip-sync $arr
    fi
    unset arg
}

pcomp () {
    echo "Hello, pip-compile'ing now"
    subfolder=$1
    ssubfolder=$2
    files_s=("requirements.test.in" "requirements.dev.in" "requirements.in")
    files_t=("requirements.test" "requirements.dev" "requirements.frozen")


    # If we have argument
    if [[ ! -z "$subfolder/$ssubfolder" ]]; then
    echo "The folder $subfolder/$ssubfolder Exists!"
        i=0
        while [ $i -lt ${#files_s[*]} ]; do
            echo "Cheking $subfolder/$ssubfolder/${files_s[$i+1]} file"
            if [ -f "${PWD}/$subfolder/$ssubfolder/${files_s[$i+1]}" ]; then
                echo "Let's compile $subfolder/$ssubfolder/${files_s[$i+1]}"
                pip-compile --emit-index-url --upgrade --output-file="${PWD}/$subfolder/$ssubfolder/${files_t[$i+1]}" ${PWD}/$subfolder/$ssubfolder/${files_s[$i+1]}
            fi
            i=$(( $i + 1));
        done
    fi
    

    unset arg
}

gitclean() {
    git fetch -p
    for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do 
        git branch -D $branch; 
    done
}

(( ${+commands[docker-compose]} )) && dccmd='docker-compose' || dccmd='docker compose'
function dco() { $dccmd }
function dcb() { $dccmd build }
function dce() { $dccmd exec }
function dcps() { $dccmd ps }
function dcp() { $dccmd ps }
function dcrestart() { $dccmd restart }
function dcrm() { $dccmd rm }
function dcr() { $dccmd run }
function dcstop() { $dccmd stop }
function dcu() { $dccmd up }
function dcup() { $dccmd up }
function dcub() { $dccmd up --build }
function dcupb() { $dccmd up --build }
function dcud() { $dccmd up -d }
function dcupd() { $dccmd up -d }
function dcdn() { $dccmd down }
function dcd() { $dccmd down }
function dcl() { $dccmd logs }
function dclf() { $dccmd logs -f }
function dcpull() { $dccmd pull }
function dcstart() { $dccmd start }
function dck() { $dccmd kill }
function dct() { $dccmd top }
function deib() { docker exec -it $1 bash }
function dcudf() { docker-compose -f $1 up}
function dcuddf() { docker-compose -f $1 up -d}
unset dccmd
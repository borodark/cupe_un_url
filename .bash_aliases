
alias mdgc='mix do deps.get, deps.compile'
alias mcc='mix do clean, compile'
alias mt='mix test'
alias mf='mix format'

export U_ID=$UID

alias dcu='U_ID=$UID docker-compose up --remove-orphans'
alias dcd='U_ID=$UID docker-compose down --remove-orphans'
alias dps="docker ps --format '{{.Names}} <---> {{.Command}}'"
alias dpsa='dps -a'

function de() { docker exec -it "$@" bash ;}
alias da='docker attach'
alias dcud='docker-compose up -d'

alias grex='grep -r --include "*.ex"'
alias grexs='grep -r --include "*.exs"'
alias greyml='grep -r --include "*.yml"'
alias greyaml='grep -r --include "*.yaml"'
alias grej='grep -r --include "*.java"'

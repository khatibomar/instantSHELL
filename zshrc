# instantOS zshrc

[ -z "$TMUX" ] && command -v tmux &> /dev/null && exec tmux && exit

# TODO: new colorscheme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#CE50DD,fg+:#ffffff,bg+:#626A7E,hl+:#E0527E
--color=info:#4BEC90,prompt:#6BE5E7,pointer:#E7766B,marker:#CFCD63,spinner:#5293E1,header:#579CEF
'

setopt promptsubst
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

autoload -Uz compinit
compinit

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC="true"
bindkey -e

if ! [ -e .zsh_plugins.sh ]
then
    echo "loading plugin bundle"
    antibody bundle < /usr/share/instantshell/bundle.txt > ~/.zsh_plugins.sh
fi

source ~/.zsh_plugins.sh

export STARSHIP_CONFIG=/usr/share/instantshell/starship.toml
eval "$(starship init zsh)"

export LESS='-R --use-color -Dd+r$Du+b'
alias ls='ls --color=auto'
alias vi=nvim
alias vim=nvim


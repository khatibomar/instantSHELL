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

if ! [ -e .zsh_plugins.zsh ]
then
    echo "loading plugin bundle"
    BUNDLEFILE="${BUNDLEFILE:-/usr/share/instantshell/bundle.txt}"
    if command -v antibody
    then
        antibody bundle < "$BUNDLEFILE" > ~/.zsh_plugins.zsh
    else
        # TODO add local antidote mirror to package to avoid zinit type situations
        # clone antidote if necessary and generate a static plugin file
        zhome=${ZDOTDIR:-$HOME}
        if [[ ! $zhome/.zsh_plugins.zsh -nt $zhome/.zsh_plugins.txt ]]; then
            [[ -e $zhome/.antidote ]] \
                || git clone --depth=1 https://github.com/mattmc3/antidote.git $zhome/.antidote
            [[ -e $zhome/.zsh_plugins.txt ]] || touch $zhome/.zsh_plugins.txt
            (
                source $zhome/.antidote/antidote.zsh
                antidote bundle <"$BUNDLEFILE" >$zhome/.zsh_plugins.zsh
            )
        fi
    fi
fi

source ~/.zsh_plugins.zsh

export STARSHIP_CONFIG=/usr/share/instantshell/starship.toml
eval "$(starship init zsh)"

export LESS='-R --use-color -Dd+r$Du+b'
alias ls='ls --color=auto'
alias vi=nvim
alias vim=nvim


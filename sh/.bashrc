# Shell Options

CURRENTSHELL=$(ps -p $$ -o comm=)

if [[ "$0" == "bash" ]]; then
    shopt -s cdspell
    shopt -s autocd
fi

export LD_PRELOAD=""
unset LD_PRELOAD

# eval "$(starship init bash)"
eval "$(zoxide init bash --cmd cd)"

function exp-rel {
    cat ~/.local/state/caelestia/sequences.txt 2>/dev/null
}

exp-rel
source ~/.sh_aliases
source ~/.sh_funcs

# Variables
export GOOGLE_CLOUD_PROJECT="rich-city-477114-q5"

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# -- PATH --
# opencode
export PATH=/home/eiedouno/.opencode/bin:$PATH
# pipx
export PATH="$PATH:/home/eiedouno/.local/bin"
export PATH="/usr/lib/jvm/java-25-openjdk/bin:$PATH"
export PATH="/home/eiedouno/.bun/bin:$PATH"
export PATH="$PATH:/home/eiedouno/.cargo/bin"

# Autorun
# Opening animtion
# clear

# Added by Antigravity CLI installer
export PATH="/home/eiedouno/.local/bin:$PATH"

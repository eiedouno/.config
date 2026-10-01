function exp-rel {
	cat ~/.local/state/caelestia/sequences.txt 2>/dev/null
}
exp-rel

### OMZ ###
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(zsh-abbr fast-syntax-highlighting)

# init OMZ
source $ZSH/oh-my-zsh.sh

# User Configuration
source ~/.bashrc

command_not_found_handler() {
	if [[ -f "./$1" ]]; then
		printf '%b' "\e[34mHint: use ./$1\n\e[0m./$*\n"
		"./$1"
	else
		#printf "\e[31mIdk wut u want bro\n"
		printf "\e[31m\e[1m\"$*\"\n ^\e[$((${#1}-1))b \e[34m<-- \e[35mTs is not a command bruv DX\n\e[0m"
		local carc
		carc="$(compgen -c | rg "^$1")"
		if [[ -n "$carc" ]]; then
			printf "\n\e[32mPossible related commands: \e[34m${carc//$'\n'/ }\n\e[0m"
		fi
	fi
}

# Create a widget that inserts a space
insert-space() {
	LBUFFER+=" "
}
zle -N insert-space
bindkey '^F' insert-space

setopt aliases
bindkey -v
bindkey " " abbr-expand-and-insert
bindkey "^ " insert-space
eval "$(starship init zsh)"

# Added by Antigravity CLI installer
#export PATH="/home/eiedouno/.local/bin:$PATH"

# Autostart
stty -echo
fastfetch --disable-linewrap --pipe false | echol
stty echo

# fastfetch --disable-linewrap true --kitty /home/eiedouno/Pictures/ArchLinuxLogo.png --logo-width 22 --logo-height 10 --pipe false | echol

openprompt() {
	setopt local_options no_notify no_monitor
	stty -echo
	stty intr s

	clear
	printf "\e[0;0H\e[0m\e[31mHyptonics AE 2.4.1 // ZL_1601\e[999;0H\e[32mArch Linux\e[999;999H\e[16DRHEL to USA // TS\e[0;0H"
	printf "\e[$(($(tput lines) / 2 - 20))B"

	if [[ $printpromptcfg != false ]]; then
		local fifo
		fifo=$(mktemp -u)
		mkfifo "$fifo" 2>/dev/null

		{
			echol <"$fifo" &
		}
		echol_pid=$!

		_openprompt_cancel() {
			exec {fd}>"$fifo" # open + immediately close the write end
			exec {fd}>&-      # closes it, echol gets EOF, loop ends
			kill "$echol_pid" 2>/dev/null
			wait "$echol_pid" 2>/dev/null
			rm -f "$fifo"
			stty echo
			trap - SIGINT
			stty intr ^C
			printf "\e[3J\e[999A"
            disown 2>/dev/null
		}
		trap '_openprompt_cancel; return' SIGINT

		fastfetch --pipe false >"$fifo" # blocks until echol reads it all
		rm -f "$fifo" >/dev/null 2>&1
		wait "$echol_pid" >/dev/null 2>&1
	fi

	stty intr ^C

	# If we get here, animation finished normally
    { disown & } 2>/dev/null
	[[ $printpromptcfg == false ]] || printf "${prompta}\n" | echos
	[[ $printpromptcfg == false ]] || printf "${promptb}\e[?25l\e[70D\e[${gitpromptc}A\e[0m" | echos

	stty echo
	trap - SIGINT
	printf "\e[?25h"
	#    printf "%b" "\e[94m    _             _       _     _
	#   / \   _ __ ___| |__   | |   (_)_ __  _   ___  __
	#  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /
	# / ___ \| | | (__| | | | | |___| | | | | |_| |>  <
	#/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\\
	#" | echol
}

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

#
# ~/.bash_profile
#

if [[ $(tty) = "/dev/tty1" ]]; then
    exec start-hyprland || systemctl soft-reboot || exit
elif [[ "$(tty)" != "/dev/tty*" ]]; then
    exec bash
fi

sleep 0.5
printf "\e[1m\e[32mAccess granted. Waiting for response from host..."
sleep 1
printf " \e[1m\e[32mHost responded '0' (OK)"
sleep 0.3
printf "\nProceeding with startup..."
sleep 0.2

#naush
#[[ -f ~/.bashrc.bak ]] && . ~/.bashrc.bak || [[ -f ~/.bashrc ]] && . ~/.bashrc

# Created by `pipx` on 2026-01-08 15:57:31
export PATH="$PATH:/home/eiedouno/.local/bin"
export PATH="$PATH:/home/eiedouno/.cargo/bin"

# Added by Antigravity CLI installer
export PATH="/home/eiedouno/.local/bin:$PATH"

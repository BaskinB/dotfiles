#  ____            _    _       ____     
# |  _ \          | |  (_)     |  _ \    Brad Baskin(BaskinB)
# | |_) | __ _ ___| | ___ _ __ | |_) |   https://www.youtube.com/channel/UC7Gu8u2uOAAvzpDC31CnjVg
# |  _ < / _` / __| |/ / | '_ \|  _ <    https://twitch.tv/BaskinB
# | |_) | (_| \__ \   <| | | | | |_) |
# |____/ \__,_|___/_|\_\_|_| |_|____/ 
#
                                     
# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Custom configuration
neofetch

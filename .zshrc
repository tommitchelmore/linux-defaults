export ZSH="/home/tom/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting docker-compose npm)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias tb="nc termbin.com 9999"
neofetch

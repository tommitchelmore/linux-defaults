#!/bin/sh

echo "Generating ssh key..."
cat /dev/zero | ssh-keygen -t ed25519 -q -N ''

echo "Installing dependencies, AdoptOpenJDK 15 (Go away Oracle!), Node 15 & Yarn..."

sudo apt install zsh
sudo su - <<EOF

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb focal main" | sudo tee /etc/apt/sources.list.d/adoptopenjdk.list
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt update && apt upgrade
apt install -y vim apt-transport-https gnupg gcc g++ make nodejs yarn
apt install -y neofetch adoptopenjdk-15-hotspot

EOF

echo "Setting git, npm and yarn configs"

git config --global user.email "tommitchelmore@outlook.com"
git config --global user.name "Thomas Mitchelmore"
yarn config set init-author-name "Thomas Mitchelmore" -g
yarn config set init-author-email "tommitchelmore@outlook.com" -g
yarn config set init-author-url "https://tommitchelmore.com" -g
yarn config set init-license "UNLICENSED" -g

#*sigh* npm just has to be awkward..
sudo npm config set init-author-name "Thomas Mitchelmore" -g
sudo npm config set init-author-email "tommitchelmore@outlook.com" -g
sudo npm config set init-author-url "https://tommitchelmore.com" -g
sudo npm config set init-license "UNLICENSED" -g

echo "Installing zsh and vim plugins..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qa
echo "Copying dotfiles..."
cp .[!.]* ~/
echo "Changing default shell"
sudo chsh -s /bin/zsh $USER
env zsh
source ~/.zshrc

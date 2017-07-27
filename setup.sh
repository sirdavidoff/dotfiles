SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

echo "Setting up Vim..."

#mv ~/.vimrc ~/.vimrc.bak
ln -s "$SCRIPTPATH/vim/vimrc" ~/.vimrc

#mv ~/.vim ~/.vim.bak
ln -s "$SCRIPTPATH/vim" ~/.vim


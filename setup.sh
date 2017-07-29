SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

# Remove existing symlink or make backup if existing file
function removeExisting() {
	if [ -L "$1" ]; then
		rm -f "$1"
	elif [ -f "$1" ]; then
		mv "$1" "$1.backup"
	fi
}



echo "Setting up Vim..."

removeExisting ~/.vimrc
ln -s "$SCRIPTPATH/vim/vimrc" ~/.vimrc

removeExisting ~/.vim
ln -s "$SCRIPTPATH/vim" ~/.vim




echo "Setting up Hammerspoon..."

DIR="$HOME/.hammerspoon"
if [ -e "$DIR" ]; then
	removeExisting "$DIR/init.lua"
	ln -s "$SCRIPTPATH/hammerspoon/init.lua" "$DIR/init.lua"
else
	echo "Hammerspoon not installed!"
fi




echo "Setting up Karabiner..."

# Note the weird stuff going on with quotes here; apparently a ~ isn't expanded if it's in quotes
DIR="$HOME/Library/Application Support/Karabiner"
if [ -e "$DIR" ]; then
	removeExisting "$DIR/private.xml"
	ln -s "$SCRIPTPATH/karabiner/private.xml" "$DIR/private.xml"
else
	echo "Karabiner not installed!"
fi





echo "Installing Powerline fonts..."

# Can't include globs (e.g. *) in quoted strings, so we use double-quoted ones
cp "$SCRIPTPATH/powerline-fonts/SourceCodePro/"*."otf" ~/Library/fonts/





if [ ! $SHELL == $(which zsh) ]; then
	echo "Changing the default shell to ZSH"
	chsh -s $(which zsh)
fi





echo "Setting up Oh My ZSH..."

# Note the weird stuff going on with quotes here; apparently a ~ isn't expanded if it's in quotes
DIR="$HOME/.oh-my-zsh"
if [ -e "$DIR" ]; then
	removeExisting ~/.zshrc
	ln -s "$SCRIPTPATH/oh-my-zsh/zshrc" ~/.zshrc
	echo "Don't forget to install the .itermcolours in the oh-my-zsh directory!"

	removeExisting "$DIR/plugins/zsh-autosuggestions"
	ln -s "$SCRIPTPATH/oh-my-zsh/zsh-autosuggestions" "$DIR/plugins/zsh-autosuggestions"
else
	echo "Oh My ZSH not installed!"
fi




echo "You need to set up Alfred yourself, by going to settings and pointing the sync folder to Alfred.alfredpreferences"

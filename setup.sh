SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

# Remove existing symlink or make backup if existing file
function removeExisting() {
	if [ -L "$1" ]; then
		rm -f "$1"
	elif [ -f "$1" ]; then
		mv "$1" "$1.backup"
	fi
}




echo "Setting up environment variables..."
sed "s|DOTFILES_PATH|$SCRIPTPATH|g" env/environment_template.plist > environment.plist
mv environment.plist "$HOME/Library/LaunchAgents"



echo "Setting up Vim..."

removeExisting ~/.vimrc
ln -s "$SCRIPTPATH/vim/vimrc" ~/.vimrc

# Remove links vim folder in dotfiles that may have been created
# by earlier version of this script
if [ -L ~/.vim ]; then
  rm ~/.vim
fi
# Create the .vim dir if it doesn't exist already
mkdir .vim > /dev/null 2>&1



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


echo "Setting up Karabiner Elements..."

# Note the weird stuff going on with quotes here; apparently a ~ isn't expanded if it's in quotes
DIR="$HOME/.config/karabiner"
if [ -e "$DIR" ]; then
  removeExisting "$DIR/karabiner.json"
  ln -s "$SCRIPTPATH/karabiner/karabiner.json" "$DIR/karabiner.json"
else
  echo "Karabiner Elements not installed!"
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



echo ""
echo "You need to set up Alfred yourself, by going to settings and pointing the sync folder to:"
echo "  $SCRIPTPATH/Alfred/Alfred.alfredpreferences"

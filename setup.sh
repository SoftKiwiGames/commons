if [ -n "$BASH_VERSION" ]; then
    echo "Your shell is BASH"
elif [ -n "$ZSH_VERSION" ]; then
    echo "Your shell is ZSH"
else
    echo "Your current shell is not Bash or Zsh. Aborting."
    exit 1
fi

mkdir -p ~/.softkiwigames

# install Rust and Cargo
if [ ! -e "/usr/bin/cargo" ] && [ ! -e "$HOME/.cargo/bin/cargo" ]; then
    echo "Cargo is not installed. Installing Rust..."
    
    # Download and run the Rust installation script
    curl https://sh.rustup.rs -sSf | sh

    # Add Rust binaries to PATH
    if [ -d "$HOME/.cargo/bin" ]; then
        export PATH="$HOME/.cargo/bin:$PATH"
    fi

    echo "Rust has been installed."
else
    echo "Cargo is already installed."
fi

# install Rust packages
echo "Installing cargo packages..."
cargo install git-delta exa bat hwatch

echo "Linking configuration files..."
ln -f -s "$(pwd)/aliases.sh" ~/.softkiwigames/aliases.sh
ln -f -s "$(pwd)/exports.sh" ~/.softkiwigames/exports.sh
ln -f -s "$(pwd)/rc.sh" ~/.softkiwigames/rc.sh

. ~/.softkiwigames/rc.sh

echo
echo "Manual steps (one time setup):"
echo "- add .gitconfig content to your git-delta configuration"
echo
echo "    cat .gitconfig >> ~/.gitconfig"
echo
echo "  now check if config was added correctly:"
echo
echo "    cat ~/.gitconfig"
echo
echo "- add this to your .zshrc or .bashrc file:"
echo
echo "    [ -f ~/.softkiwigames/rc.sh ] && . ~/.softkiwigames/rc.sh"
echo

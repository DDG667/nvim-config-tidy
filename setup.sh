
# git clone https://github.com/DDG667/nvim-config-tidy
nvim -u nvim-config-tidy/init.lua

echo "Do you like it? [Y/n]"
read like
if [ "$like" != Y ];
then
    exit 1
fi

if test -d ~/.config/nvim;
then
    echo "We need to delete your original configuration file (~/.config/nvim/*)"
    read -p "Do you want to continue? [Y/n]" choose
fi

if [ "$choose" != n ];
then
    rm -rf ~/.config/nvim/
    mkdir -p ~/.config/nvim/
    mv nvim-config-tidy/init.lua ~/.config/nvim/
    # rm -rf nvim-config-tidy
    nvim
else
    echo "You can use nvim -u $(pwd)/nvim-config-tidy/init.lua to startup."
fi

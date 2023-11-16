# Making .config and Moving config files and background to Pictures
builddir=$1
cd $builddir

mkdir -p /home/$username/.local/share/fonts
mkdir -p /home/$username/.config
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp -R $builddir/dotconfig/* /home/$username/.config/
cp $buildir/data/bg.jpg /home/$username/Pictures/backgrounds/
mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username

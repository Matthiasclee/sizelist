mkdir ~/sizelist
echo "PATH=\$PATH:$HOME/sizelist" >> ~/.bashrc

cp scan_dir.sh ~/sizelist
cp list_data.sh ~/sizelist
cp sizelist ~/sizelist
chmod +x ~/sizelist/sizelist

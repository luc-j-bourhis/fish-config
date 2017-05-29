function clean_downloads
	cd ~/Downloads
    find . -name .DS_Store -delete
    find . -mtime +30d ! -type d -delete
    find . -type d -empty -delete
end

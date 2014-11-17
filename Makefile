#
package_dir="Packages"
rlibs_dir="R_Lib"
t=
all : check install

check :
	@echo "Checking for R..."
	@command -v R >/dev/null 2>&1 || { echo >&2 "I require R but it's not installed.  Aborting."; exit 1; }
	@echo "Done!"
	@echo "Checking for GCC..."
	@command -v gcc >/dev/null 2>&1 || { echo >&2 "I require GCC but it's not installed.  Aborting."; exit 1; }
	@echo "Done!"
	@echo "Checking for Python..."
	@command -v python >/dev/null 2>&1 || { echo >&2 "I require Python but it's not installed.  Aborting."; exit 1; }
	@echo "Done!"
	
install :
	mkdir -p $(rlibs_dir)
	
	#@read -r -p "Update installed R-packages? [y/N]: " upd; \
	#[ "$$upd" == "N" ] || [ "$$upd" == "n" ] || (([ "$$upd" == "y" ] || [ "$$upd" == "Y" ] || [ "$$upd" == \n ]) && Rscript $(package_dir)/update.R);
	
	@echo "Installed required libraries..."
	Rscript $(package_dir)/install.R
	@echo "Installing BLASTParser package..."
	@rm -rf $(package_dir)/blastparser/src/*.o
	@rm -rf $(package_dir)/blastparser/src/*.so
	R CMD INSTALL $(package_dir)/blastparser -l $(rlibs_dir)
	@echo "Done!"
	
	@echo "Unzipping data files..."
	@rm -rf data/__MACOSX
	@rm -rf data/even
	@rm -rf data/staggered
	unzip data/even.zip -d data/
	unzip data/staggered.zip -d data/
	
	@echo "Cleaning up..."
	@rm -rf data/__MACOSX
	@ls > content # Making content of this folder
	@echo "Installation completed."

clean :
	@echo "Cleaning up..."
	@rm -rf $(rlibs_dir)
	@rm -rf analysis
	@rm -rf .Rhistory
	@rm -rf .DS_Store
	@rm -rf $(package_dir)/blastparser/src/*.o
	@rm -rf $(package_dir)/blastparser/src/*.so
	@rm -rf data/__MACOSX
	@rm -rf data/even
	@rm -rf data/staggered
	@echo "Done!"

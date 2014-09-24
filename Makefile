#
package_dir="Packages"
#
all : check install

check :
	@echo "Checking for R..."
	@command -v R > /dev/null 2>&1 || { echo > &2 "I require R but it's not installed.  Aborting."; exit 1; }
	@echo "Done!"
	@echo "Checking for GCC..."
	@command -v gcc > /dev/null 2>&1 || { echo > &2 "I require GCC but it's not installed.  Aborting."; exit 1; }
	@echo "Done!"
	@echo "Checking for Python..."
	@command -v python > /dev/null 2>&1 || { echo > &2 "I require Python but it's not installed.  Aborting."; exit 1; }
	@echo "Done!"
	
install :
	
	@echo "Installing required R packages..."
	@$(package_dir)/./install.R
	@echo "Done!"
	
	@echo "Installing BLASTParser package..."
	@rm -rf $(package_dir)/blastparser/src/*.o
	@rm -rf $(package_dir)/blastparser/src/*.so
	R CMD INSTALL $(package_dir)/blastparser
	@echo "Done!"
	
	@echo "Installing CDHITConverter package..."
	R CMD INSTALL $(package_dir)/cdhitconverter
	@rm -rf R CMD INSTALL $(package_dir)/cdhitconverter/src/*.o
	@rm -rf R CMD INSTALL $(package_dir)/cdhitconverter/src/*.so
	@echo "Done!"
	
	@echo "Unzipping data files..."
	@rm -rf data/__MACOSX
	@rm -rf data/LTP
	unzip data/LTP.zip -d data/
	@rm -rf Evaluation/data/__MACOSX
	@rm -rf Evaluation/data/even
	@rm -rf Evaluation/data/staggered
	unzip Evaluation/data/even.zip -d Evaluation/data/
	unzip Evaluation/data/staggered.zip -d Evaluation/data/
	
	@echo "Cleaning up..."
	@rm -rf Evaluation/data/__MACOSX
	@rm -rf data/__MACOSX
	@ls > content # Making content of this folder
	@echo "Installation completed."

clean :
	@echo "Cleaning up..."
	@rm -rf analysis
	@rm -rf .Rhistory
	@rm -rf .DS_Store
	@rm -rf $(package_dir)/blastparser/src/*.o
	@rm -rf $(package_dir)/blastparser/src/*.so
	@rm -rf R CMD INSTALL $(package_dir)/cdhitconverter/src/*.o
	@rm -rf R CMD INSTALL $(package_dir)/cdhitconverter/src/*.so
	@rm -rf Evaluation/analysis
	@rm -rf data/__MACOSX
	@rm -rf data/LTP
	@rm -rf Evaluation/data/__MACOSX
	@rm -rf Evaluation/data/even
	@rm -rf Evaluation/data/staggered
	@echo "Done!"

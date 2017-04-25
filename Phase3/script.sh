# Markdown to LaTeX Dissertation Build Script

# Captures the date for later use
date=`date +"%m-%d-%y-%H%M"`

# Move into the Sections folder
cd ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/ReportSections

# Gather the files which together constitute a dissertation into one place. Add Section Files Here/ Aims.md Background.md Content.md > sectionbuild.md
cat ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/ReportSections/phase1.md > sectionbuild.md

# Copy into the build folder
cp  sectionbuild.md ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/sectionbuild.md

# Move into the Build folder
cd ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/

# Run Pandoc to turn the markdown file with the bulk of the document into a .TeX file
pandoc -f markdown --latex-engine=xelatex -R -i sectionbuild.md -o pandocked.tex

# Remove some of the junk that Markdown adds when converting to TeX.
sed -i .bak 's/\[<+->\]//g' ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/pandocked.tex
sed -i .bak 's/\\def\\labelenumi{\\arabic{enumi}.}//g' ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/pandocked.tex
sed -i .bak 's/\\itemsep1pt\\parskip0pt\\parsep0pt//g' ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/pandocked.tex

# This turns the word "F0" into a pretty version, with a subscript.
perl -pi -w -e 's/F0/F\$_{0}\$/g;' ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/pandocked.tex

# Concatenate the header file (with the preambles, TOC, etc), the pandoc-created TeX file, and the footer file (with the bibliography) into a single buildable TeX file
cat ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/header.tex ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/pandocked.tex ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/footer.tex > ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/Report.tex

# Build the TeX once without stopping for errors (as the hyperref plugin throws errors on the first run)
/Library/TeX/texbin/xelatex -output-driver="/Library/TeX/texbin/xdvipdfmx" -interaction=nonstopmode -synctex=1 Report.tex

# Render the bibliography based on the prior file
/Library/TeX/texbin/bibtex Report

# Render the file twice more, to ensure that the bibliographical references are included and that the TOC reflects everything accurately
/Library/TeX/texbin/xelatex -output-driver="/Library/TeX/texbin/xdvipdfmx" -synctex=1 Report
/Library/TeX/texbin/xelatex -output-driver="/Library/TeX/texbin/xdvipdfmx" -synctex=1  Report

# Copy the PDF and final TeX out of the build folder for accessibility
cp Report.tex ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestReport.tex
cp Report.pdf ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestReport.pdf

# Open the PDF generated in my PDF reader of choice
open /Applications/preview.app ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestReport.pdf

# Archives a copy of the md and tex files by date, leaving a trail of prior drafts
tar cfvz ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/latest.tar.gz sectionbuild.md Report.tex header.tex footer.tex

# Rename the archived version, including the date generated.
mv ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/LatestBuild/latest.tar.gz ~/Documents/University/Year\ 4/Sensors\,\ Signals\ and\ Control/Control/Coursework/Phase123/Phase3/Archive/rep_bu_$date.tar.gz

# killall Terminal

###################################################
# TODO before reset your computer
# Basic script to get list of packages so you do not have to do it manually
# Will Vieira
# December 19, 2019
###################################################


# dir
mkdir packages

# Atom packages

  # Get list of atom packages
  apm list --installed --bare > atom-list.txt
  # remove version of package
  sed 's/@.*//' atom-list.txt > packages/atom_packages.txt
  # remove file
  rm atom-list.txt

#

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



# R pacakges

  Rscript -e "
  # get all packages;
  allPackages = installed.packages(.Library)[, 1];
  # which are github?
  isGithub = sapply(allPackages, function(x) {!is.null(packageDescription(x)['GithubRepo'][[1]])});
  # get userName and package Name together
  gh_pkgs = sapply(allPackages[isGithub], function(x) paste0(packageDescription(x)['GithubRepo'][[1]], '/', packageDescription(x)['GithubUsername'][[1]]));
  # save CRAN pacakges
  write.table(allPackages[!isGithub], file = 'packages/R_CRAN_packages.txt', row.names = FALSE, col.names = FALSE);
  # save github packages;
  write.table(gh_pkgs, file = 'packages/R_github_packages.txt', row.names = FALSE, col.names = FALSE);
  "

#

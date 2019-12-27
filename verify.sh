

##############################################
# Verify if all applications and packages were installed correctly
# Will Vieira
# December, 29 2019
##############################################

#### Steps ######
# Get apps name which should have been installed
# Get all installed apps and packages
# Compare then and print which ones failed
# remove temporary files
#################


mkdir verif


## Get apps name which should have been installed

  # get all words after `brew install`
  cat macOS_setup.sh | grep 'brew install' | awk '{print $3}' > verif/brew_toInstall.txt

  # get all words after `brew cask install`
  cat macOS_setup.sh | grep 'brew cask install' | awk '{print $4}' > verif/brewcask_toInstall.txt

##



## Get all installed apps and packages

  # brew
  brew ls > verif/brew_installed.txt

  # brew cask
  brew cask ls > verif/brewcask_installed.txt

  # atom packages
    # Get list of atom packages
    apm list --installed --bare > atom-list.txt
    # remove version of package
    sed 's/@.*//' atom-list.txt > verif/atom_installed.txt
    # remove file
    rm atom-list.txt
  #

  # R packages
  Rscript -e "# get all packages;
  allPackages = installed.packages(.Library)[, 1];
  # which are github?
  isGithub = sapply(allPackages, function(x) {!is.null(packageDescription(x)['GithubRepo'][[1]])});
  # get userName and package Name together
  gh_pkgs = sapply(allPackages[isGithub], function(x) paste0(packageDescription(x)['GithubUsername'][[1]], '/', packageDescription(x)['GithubRepo'][[1]]));
  # save CRAN pacakges
  if(length(allPackages[!isGithub]) != 0) write.table(allPackages[!isGithub], file = 'verif/R_CRAN_installed.txt', row.names = FALSE, col.names = FALSE);
  # save github packages;
  if(length(gh_pkgs) != 0) write.table(gh_pkgs, file = 'verif/R_github_installed.txt', row.names = FALSE, col.names = FALSE);"

##



## Compare then and print which ones failed

  mkdir packages_toReinstall

  Rscript -e "

  # load all info
  fls = tools::file_path_sans_ext(dir('verif'))
  for(i in fls) assign(i, read.table(paste0('verif/', i, '.txt'))[, 1])
  atom_toInstall = read.table('packages/atom_packages.txt')[, 1]
  R_CRAN_toInstall = read.table('packages/R_CRAN_packages.txt')[, 1]
  R_github_toInstall = read.table('packages/R_github_packages.txt')[, 1]

  # Compare brew
  notInstalled = as.character(brew_toInstall[!(brew_toInstall %in% brew_installed)])
  if(length(notInstalled) != 0) {
    cat('\n', paste(c('brew applications not installed:', notInstalled), collapse = '\n-'), '\n\n')
    write.table(notInstalled, file = 'packages_toReinstall/brew_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
  }

  # Compare brew cask
  notInstalled = as.character(brewcask_toInstall[!(brewcask_toInstall %in% brewcask_installed)])
  if(length(notInstalled) != 0) {
    cat(paste(c('brew cask applications not installed:', notInstalled), collapse = '\n-'), '\n\n')
    write.table(notInstalled, file = 'packages_toReinstall/brewcask_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
  }

  # Compare Atom packages
  notInstalled = as.character(atom_toInstall[!(atom_toInstall %in% atom_installed)])
  if(length(notInstalled) != 0) {
    cat(paste(c('Atom packages not installed:', notInstalled), collapse = '\n-'), '\n\n')
    write.table(notInstalled, file = 'packages_toReinstall/atom_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
  }

  # Compare R CRAN packages
  if(exists('R_CRAN_installed')) {
    notInstalled = as.character(R_CRAN_toInstall[!(R_CRAN_toInstall %in% R_CRAN_installed)])
    if(length(notInstalled) != 0) {
      cat(paste(c('R CRAN packages not installed:', notInstalled), collapse = '\n-'), '\n\n')
      write.table(notInstalled, file = 'packages_toReinstall/Rcran_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
    }
  }else{
    cat(paste(c('R CRAN packages not installed:', R_CRAN_toInstall), collapse = '\n-'), '\n\n')
    write.table(R_CRAN_toInstall, file = 'packages_toReinstall/Rcran_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
  }

  # Compare R github packages
  if(exists('R_github_installed')) {
    notInstalled = as.character(R_github_toInstall[!(R_github_toInstall %in% R_github_installed)])
    if(length(notInstalled) != 0) {
      cat(paste(c('R CRAN packages not installed:', as.character(notInstalled)), collapse = '\n-'), '\n\n')
      write.table(notInstalled, file = 'packages_toReinstall/Rgithub_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
    }
  }else{
    cat(paste(c('R github packages not installed:', as.character(R_github_toInstall)), collapse = '\n-'), '\n\n')
    write.table(R_github_toInstall, file = 'packages_toReinstall/Rgithub_ToReinstall.txt', row.names = FALSE, col.names = FALSE)
  }

  #"

##



## Remove temporary files

 rm -rf verif

##

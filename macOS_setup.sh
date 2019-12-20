#!/bin/bash

sudo -v # ask for sudo upfront


##------------- Install XCode Command Line Tools

  ## Accept license
  ## use xcode-select -p to check whether Xcode is installed
  xcode-select --install
  sudo xcodebuild -license

##



##------------- Installing Homebrew

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##



##------------- Refresh repositories

  brew update

##



##------------- Utilitaries

  brew cask install adobe-acrobat-reader
  brew cask install google-chrome
  brave-browser brave-browser
  brew install graphicsmagick
  brew install imagemagick
  brew install ffmpeg
  brew install hugo
  brew install node
  brew cask install transmission
  brew cask install vlc
  brew install youtube-dl
  brew install wget
  brew cask flux
  brew cask color-oracle
  brew cask writefull
  brew cask typora

##



##------------- Communications app

  brew cask install skype
  brew cask install rambox

##



##------------- Reference manager

  brew cask install mendeley

##



##------------- Files Hosting Services

  brew cask install dropbox
  brew cask install owncloud

##



##------------- Image editor

  brew cask install xquartz
  brew install caskformula/caskformula/inkscape

##



##------------- Atom, Packages & Keybindings

  # Appplication
  brew cask install atom

  # Packages
  apm install --packages-file packages/atom_packages.txt

  # Keybindings
  echo "'atom-workspace atom-text-editor:not([mini])':
    'cmd-enter': 'r-exec:send-command' `# r execution keybind`

##



##------------- R, Pacakges & Profile

  # Application
  brew install r

  # CRAN packages
  Rscript -e "
  pkgNames = read.table('packages/R_CRAN_packages.txt')[, 1];
  install.packages(pkgNames, repos='http://cran.us.r-project.org', dependencies = TRUE, type = 'source');
  pkgNames = read.table('packages/R_github_packages.txt')[, 1];
  devtools::install_github(pkgNames, upgrade = 'always');
  "

  # Profile
  echo 'options(warnPartialMatchArgs = TRUE, warnPartialMatchDollar = TRUE, warnPartialMatchAttr = TRUE)

  ### GENERAL OPTIONS -----------------------------

  options(
    prompt          = "> ",
    continue        = "+ ",
    width           = 80,
    scipen          = 100,
    warn            = 0,
    editor          = "Atom",
    stringsAsFactor = TRUE,
    tab.width       = 2
  )

  ### GRAPHICAL DEVICE DIMENSIONS -----------------

  grDevices::quartz.options(
    width  = 6,
    height = 5
  )

  ### CRAN MIRROR ---------------------------------

  local({
    r <- getOption("repos")
    r["CRAN"] <- "http://cran.rstudio.com/"
    options(repos = r)
  })

  ### QUIT R WITHOUT SAVING -----------------------

  .env <- new.env()
  .env$q <- function(save = "no", ...) {
    quit(save = save, ...)
  }
  attach(.env, warn.conflicts = FALSE)

  ### DEFAULT WORKING DIRECTORY -------------------

  # setwd("~/Desktop")' > ~/.Rprofile

##



##------------- Pyhton

  brew install python3

##



##------------- Pandoc and Pandoc's filters

  brew install pandoc
  brew install pandoc-citeproc
  pip install pandoc-fignos
  pip install pandoc-tablenos
  pip install pandoc-eqnos

##



##------------- Install and setup Git, Github & GithLab

  brew install git
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
  git config --global user.name \"$FIRSTNAME $LASTNAME\"
  git config --global user.email \"$EMAIL\"
  git config --global github.user \"$GITHUB\"
  git config --global credential.helper osxkeychain  # save my credentials
  ssh-keygen -t rsa -b 4096 -C \"$EMAIL\"


  # Download github and gitlab repos
  # github
  mkdir ~/GitHub
  cd ../GitHub
  for REPO in "${GITHUB_REPOS[@]}"
  do
    git clone https://github.com/$REPO.git
  done
  cd ..

  # gitlab
  mkdir ~/GitLab
  cd GitLab
  for REPO in "${GITLAB_REPOS[@]}"
  do
    echo git clone git@$GITLAB:$REPO.git
  done
  cd ..
##



##------------- Install jekyll

  sudo gem install jekyll jekyll-language-plugin

##



##------------- Emulator

  brew install wine
  winetricks directplay # so we can play AOEII avec les copains

##



##------------- Terminal

  # Application
  brew cask install iterm2

  # Oh My Zsh #TODO
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # ~/.zshrc ZSH_THEME="agnoster" # define theme
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # autosuggestions
  # ~/.zshrc plugins=(zsh-autosuggestions)
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # syntax-highlighting
  # plugins=( [plugins...] zsh-syntax-highlighting)

  # install Source Code Pro font
  brew cask install font-source-code-pro

##



##------------- Reboot

  sudo reboot

##

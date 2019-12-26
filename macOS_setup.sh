#!/bin/sh

sudo -v # ask for sudo upfront
source .personal_info



##------------- Refresh repositories

  brew update

##



##------------- Utilitaries

  brew cask install adobe-acrobat-reader
  brew cask install brave-browser
  brew install graphicsmagick
  brew install imagemagick
  brew install ffmpeg
  brew install hugo
  brew install node
  brew cask install transmission
  brew cask install vlc
  brew install youtube-dl
  brew install wget
  brew cask install flux
  brew cask install color-oracle
  brew cask install writefull
  brew cask install typora
  brew cask install docker
  brew install nano
  brew cask install basictex # tlmgr to install further packages
  brew cask install spectacle
  brew install octave
  brew cask install mtmr

##



##------------- Communications app

  brew cask install skype
  brew cask install rambox

##



##------------- Reference manager

  mendeley mendeley-desktop

##



##------------- Files Hosting Services

  brew cask install dropbox
  brew cask install owncloud

##



##------------- Image editor

  brew cask install xquartz
  brew install caskformula/caskformula/inkscape
  brew cask install gimp

##



##------------- Atom, Packages & Keybindings

  # Appplication
  brew cask install atom

  # Packages
  apm install --packages-file packages/atom_packages.txt

  # Keybindings
  echo "'atom-workspace atom-text-editor:not([mini])':
    'cmd-enter': 'r-exec:send-command'" >> ~/.atom/keymap.cson

  # define iTerm2 as the app to send code and focusWindow to FALSE
  echo "atom.config.set('r-exec.whichApp', 'iTerm2')\natom.config.set('r-exec.focusWindow', false)" >> ~/.atom/init.coffee

  # Fix language-r snippet
  curl -L 'https://raw.githubusercontent.com/REditorSupport/atom-language-r/master/snippets/language-r.cson' > ~/.atom/packages/language-r/snippets/language-r.cson

##



##------------- R, Pacakges & Profile

  # Application
  brew install R

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
  cat ~/.ssh/id_rsa.pub > ~/Desktop/gitlab_key.txt


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

  brew cask install wine-stable
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
  git clone https://github.com/powerline/fonts.git --depth=1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts

##



## Activity watch

  # Application
  brew cask install activitywatch

  # bash script to open activity watch
  mkdir ~/scripts
  echo "#\!/bin/sh\n\n/usr/local/bin/aw-qt" > ~/scripts/launchActivitywatch.sh

  # launchctl daemon to launch activitywatch with system login
  echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
   <key>Label</key>
   <string>com.activitywatch</string>
   <key>ProgramArguments</key>
   <array><string>~/scripts/launchActivitywatch.sh</string></array>
   <key>RunAtLoad</key>
   <true/>
</dict>
</plist>' > ~/Library/LaunchAgents/com.activitywatch.plist

  launchctl load ~/Library/LaunchAgents/com.activitywatch.plist

##



## Brave (chromium) extensions

  # activititywatch
  open -a 'Brave Browser' https://chrome.google.com/webstore/detail/activitywatch-web-watcher/nglaklhklhcoonedhgnpgddginnjdadi

  # reader view
  open -a 'Brave Browser' https://chrome.google.com/webstore/detail/reader-view/iibolhpkjjmoepndefdmdlmbpfhlgjpl

##



## Caato time tracker

  brew install mas
  mas install 596816253

##



## Remotes

  # VPN openconnect
  brew install openconnect

  # start and close VPN connection
  #sudo openconnect -b -q $VPNSERVER -u VPN$USER --passwd-on-stdin < ~/bin/pass/.passfile
  #sudo kill $(ps aux | grep openconnect | grep -v grep | awk '{print $2}')

  # sshpass
  brew install http://git.io/sshpass.rb

##



## Passwords to be used with alias



##




## Alias


##



##------------- Reboot

  sudo reboot

##

#!/bin/sh

sudo -v # ask for sudo upfront
source .personal_info



## Create my repos

  mkdir ~/scripts
  mkdir ~/icons
  mkdir ~/bin

##



##------------- Refresh repositories

  brew update

##



##------------- Utilitaries

  brew cask install adobe-acrobat-reader
  brew cask install brave-browser
  brew install graphicsmagick
  brew install imagemagick@6
  brew install ffmpeg
  brew install hugo
  brew install node
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

##



## Latex packages

  sudo tlmgr update --self
  sudo tlmgr install easyreview
  sudo tlmgr install soul
  sudo tlmgr install todonotes
  sudo tlmgr install pgf
  sudo tlmgr install letltxmacro

##



##------------- Communications app

  brew cask install skype
  brew cask install rambox

##



##------------- Reference manager

  brew cask install mendeley-desktop

##



##------------- Files Hosting Services

  brew cask install dropbox
  brew cask install owncloud

##



##------------- Image editor

  brew cask install xquartz
  brew cask install inkscape
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
  echo "atom.config.set('r-exec.whichApp', 'iTerm2')\natom.config.set('r-exec.advancePosition', true)\natom.config.set('r-exec.focusWindow', false)" >> ~/.atom/init.coffee

  # Fix language-r snippet
  curl -L 'https://raw.githubusercontent.com/REditorSupport/atom-language-r/master/snippets/language-r.cson' > ~/.atom/packages/language-r/snippets/language-r.cson

##



## Libraries

  brew install udunits
  brew install gdal
  brew install gcc ccache cmake pkg-config autoconf automake
  brew install freetype fontconfig pixman gettext
  brew install libxml2
  brew cask install java
  brew install cairo libsvg librsvg
  brew install openblas
  brew install eigen armadillo
  brew install llvm
  brew install phantomjs casperjs


  ## Extra config

  # Setting language and localization variables
  sed -i "" "83i\\
  # Setting language and localization variables \\
  export LC_ALL=en_US.UTF-8 \\
  export LANG=en_US.UTF-8 \\
  \\
  " ~/.zshrc

  # link libxml2
  sed -i "" "87i\\
  # link libxml2 \\
  export PATH="/usr/local/opt/libxml2/bin:\$PATH" \\
  \\
  " ~/.zshrc
  export LDFLAGS="-L/usr/local/opt/libxml2/lib"
  export CPPFLAGS="-I/usr/local/opt/libxml2/include"
  export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

  # Java
  sed -i "" "90i\\
  # Setting \$JAVA_HOME \\
  export JAVA_HOME=\"\$(/usr/libexec/java_home)\" \\
  \\
  " ~/.zshrc
  sudo R CMD javareconf

  # Link llvm
  sed -i "" "93i\\
  # Link llvm \\
  export PATH=/usr/local/opt/llvm/bin:\$PATH \\
  \\
  " ~/.zshrc

##



##------------- R, Pacakges & Profile

  # Application
  brew install R

  # define main language
  defaults write org.R-project.R force.LANG en_US.UTF-8

  # data.table specific instalation
  mkdir ~/.R
  echo "CC=/usr/local/opt/llvm/bin/clang -fopenmp
CXX=/usr/local/opt/llvm/bin/clang++ -fopenmp
# -O3 should be faster than -O2 (default) level optimisation ..
CFLAGS=-g -O3 -Wall -pedantic -std=gnu99 -mtune=native -pipe
CXXFLAGS=-g -O3 -Wall -pedantic -std=c++11 -mtune=native -pipe
LDFLAGS=-L/usr/local/opt/gettext/lib -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib
CPPFLAGS=-I/usr/local/opt/gettext/include -I/usr/local/opt/llvm/include
CPPFLAGS=-I/usr/local/opt/gettext/include -I \$(LLVM_LOC)/include -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include" >> ~/.R/Makevars
  R -e "install.packages('data.table', repos='http://cran.us.r-project.org')"
  rm ~/.R/Makevars
  echo "CC=/usr/local/opt/llvm/bin/clang
CXX=/usr/local/opt/llvm/bin/clang++
# -O3 should be faster than -O2 (default) level optimisation ..
CFLAGS=-g -O3 -Wall -pedantic -std=gnu99 -mtune=native -pipe
CXXFLAGS=-g -O3 -Wall -pedantic -std=c++11 -mtune=native -pipe
LDFLAGS=-L/usr/local/opt/gettext/lib -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib
CPPFLAGS=-I/usr/local/opt/gettext/include -I/usr/local/opt/llvm/include" >> ~/.R/Makevars

  # CRAN packages
  Rscript -e "
  pkgNames = read.table('packages/R_CRAN_packages.txt')[, 1];
  install.packages(pkgNames, repos='http://cran.us.r-project.org', dependencies = TRUE, type = 'source', quiet = TRUE);
  pkgNames = read.table('packages/R_github_packages.txt')[, 1];
  devtools::install_github(pkgNames, upgrade = 'always');
  "

  # Profile
  cp scripts/.Rprofile ~/.Rprofile

##



##------------- Pyhton

  brew install python3

##



##------------- Pandoc and Pandoc's filters

  brew install pandoc
  brew install pandoc-citeproc
  pip3 install pandoc-fignos
  pip3 install pandoc-tablenos
  pip3 install pandoc-eqnos

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
    git clone git@$GITLAB:$REPO.git
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

  # install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # change oh my zsh theme
  sed -i "" "s/.*ZSH_THEME=\"robbyrussell\".*/ZSH_THEME=\"agnoster\"/" ~/.zshrc

  # Add autosuggestions and highlighting plugins
  # clone repos
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # syntax-highlighting
  # add to .zshrc
  sed -i "" "s/.*plugins=(git).*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc

  # install Source Code Pro font
  git clone https://github.com/powerline/fonts.git --depth=1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts

  # Hide computer and user name on terminal
  sed -i "" "75i\\
  [[ -n \"\$SSH_CLIENT\" ]] || export DEFAULT_USER=\"$USERNAME\" \\
  \\
  " ~/.zshrc

  # Remove last login message when opening terminal
  touch ~/.hushlogin

  # Add welcome msg
  sed -i "" "77i\\
  echo \"$MSG\" \\
  \\
  " ~/.zshrc

  # add color theme (edit of solarized theme)
  open -a 'iTerm' packages/myColorTheme.itermcolors

##



## My TouchBar My rules

  brew cask install mtmr

  # add my personal configuration
  cp packages/MyTouchBarMyRules.json $HOME/Library/Application Support/MTMR/items.json

  # Compile script to automate open iTerm and Atom in splitView
  osacompile -o $HOME/scripts/splitView_script.scpt scripts/splitView.applescript

  # add icons to run apple script
  cp images/icon_code.png $HOME/icons/code.png

##



## Activity watch

  # Application
  curl -LO https://github.com/ActivityWatch/activitywatch/releases/download/v0.8.4/activitywatch-v0.8.4-macos-x86_64.zip
  unzip activitywatch-v0.8.4-macos-x86_64.zip -d /Applications/
  rm activitywatch-v0.8.4-macos-x86_64.zip

  # bash script to open activity watch
  echo "#!/bin/sh\n\ncd /Applications/activitywatch\n./aw-qt" > ~/scripts/launchActivitywatch.sh

  # launchctl daemon to launch activitywatch with system login
  echo "<?xml version='1.0' encoding='UTF-8'?>
  <!DOCTYPE plist PUBLIC ''-//Apple Computer//DTD PLIST 1.0//EN' 'http://www.apple.com/DTDs/PropertyList-1.0.dtd'>
  <plist version='1.0'>
  <dict>
   <key>Label</key>
   <string>com.activitywatch</string>
   <key>ProgramArguments</key>
   <array><string>/Users/$USERNAME/scripts/launchActivitywatch.sh</string></array>
   <key>RunAtLoad</key>
   <true/>
  </dict>
  </plist>" > ~/Library/LaunchAgents/com.activitywatch.plist

  launchctl load ~/Library/LaunchAgents/com.activitywatch.plist

##



## Brave (chromium) extensions

  # activititywatch
  open -a 'Brave Browser' https://chrome.google.com/webstore/detail/activitywatch-web-watcher/nglaklhklhcoonedhgnpgddginnjdadi

  # reader view
  open -a 'Brave Browser' https://chrome.google.com/webstore/detail/reader-view/iibolhpkjjmoepndefdmdlmbpfhlgjpl

##


## Remotes

  # VPN openconnect
  brew install openconnect

  # sshpass
  brew install http://git.io/sshpass.rb

##



## Passwords to be used with alias

  # save passwords
  mkdir -p $directoryToSave

  for MYPASS in "${MYPASSWORDS[@]}"
  do
    PASS=`echo "$MYPASS" | sed 's/.*;//'`
    DIRECT=`echo $directoryToSave/$MYPASS | sed 's/;.*//'`
    echo "$PASS" > $DIRECT
  done

##



## Bash functions

  # create file to save functions
  echo "#!/bin/sh \
  \
  " > $HOME/scripts/bashFunctions.sh

  # Add functions
  DIRECT=`echo $directoryToSave/${MYPASSWORDS[0]} | sed 's/;.*//'`

  # push files to server
  echo "
mammPush() {
  sshpass -f $DIRECT scp -r $HOME/GitHub/\$1 view2301@mp2b.computecanada.ca:/home/view2301/\$2
}
  " >> $HOME/scripts/bashFunctions.sh

  # pull files from server
  echo "
mammPull() {
  sshpass -f $DIRECT scp -r view2301@mp2b.computecanada.ca:/home/view2301/\$2 $HOME/GitHub/\$2
}
  " >> $HOME/scripts/bashFunctions.sh

  # Export functions
  sed -i "" "79i\\
  source $HOME/scripts/bashFunctions.sh \\
  \\
  " ~/.zshrc

##



## Alias

  # Alias using sshpass
  for myAlias in "${MYsshpassALIAS[@]}"
  do
    IFS=';' read -ra AL <<< "$myAlias"
    echo "alias ${AL[0]}=\"sshpass -f $directoryToSave/${AL[1]} ${AL[2]}\"" >> ~/.zshrc
  done

  # Other alias
  # Open with typora
  echo "alias typ=\"open -a 'Typora'\"" >> ~/.zshrc


  # VPN
  # start and close VPN connection
  DIRECT=`echo $directoryToSave/${MYPASSWORDS[1]} | sed 's/;.*//'`
  echo "alias startVPN=\"sudo openconnect -b -q $VPNSERVER -u $VPNUSER --passwd-on-stdin < $DIRECT\"" >> ~/.zshrc
  echo "alias stopVPN=\"sudo kill \\\$(ps aux | grep openconnect | grep -v grep | awk '{print \\\$2}')\"" >> ~/.zshrc

##



##------------- Reboot

  sudo reboot

##

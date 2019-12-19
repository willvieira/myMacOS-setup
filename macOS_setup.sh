#!/bin/bash

sudo -v # ask for sudo upfront


##------------- Install XCode Command Line Tools
## Accept license
## use xcode-select -p to check whether Xcode is installed
xcode-select --install
sudo xcodebuild -license


##------------- Installing Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##------------- Refresh repositories
brew update


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


##------------- Communications app
brew cask install skype
brew cask install rambox


##------------- Reference manager
brew cask install mendeley


##------------- Files Hosting Services
brew cask install dropbox
brew cask install owncloud


##------------- Image editor
brew cask install xquartz
brew install caskformula/caskformula/inkscape



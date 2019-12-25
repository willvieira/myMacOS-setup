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



## Grant access to terminal write


##

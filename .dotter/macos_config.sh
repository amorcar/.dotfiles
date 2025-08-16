echo '[INFO] running MacOS configuration'

# Disable relative dates
# defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "yyyy-MM-dd HH:mm"
# defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "2" "yyyy-MM-dd HH:mm:ss"
# defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "3" "yyyy-MM-dd HH:mm:ss"
# defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "4" "yyyy-MM-dd HH:mm:ss"
# defaults write com.apple.finder RelativeDates -bool false
# killall Finder

# Restore default
defaults delete com.apple.finder RelativeDates
defaults delete NSGlobalDomain AppleICUDateFormatStrings
killall Finder


echo '[INFO] MacOS configuration DONE'

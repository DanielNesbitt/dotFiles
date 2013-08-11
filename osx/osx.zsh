# Some configuration options for OS X

# Disable recent files for VLC
defaults delete org.videolan.vlc.LSSharedFileList RecentDocuments
defaults write org.videolan.vlc NSRecentDocumentsLimit 0
defaults write org.videolan.vlc.LSSharedFileList RecentDocuments -dict-add MaxAmount 0

# Disable recent files for QuickTime
defaults delete com.apple.QuickTimePlayerX.LSSharedFileList RecentDocuments
defaults write com.apple.QuickTimePlayerX NSRecentDocumentsLimit 0
defaults write com.apple.QuickTimePlayerX.LSSharedFileList RecentDocuments -dict-add MaxAmount 0
# Prevent QuickTime from re-opening files
defaults write com.apple.QuickTimePlayerX NSQuitAlwaysKeepsWindows -bool false

# Prevent Preview from re-opening files
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false

# Fix the "Open with..." menus since Apple screwed them up so badly
/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
killall Finder

# Disable the dashboard since it hasn't been useful since Leopard
defaults write com.apple.dashboard mcx-disabled -boolean YES
# killall Dock

echo 'OS-X configuation complete.'
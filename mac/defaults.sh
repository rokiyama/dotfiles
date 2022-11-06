#!/bin/sh

# US 入力モードでキー長押しでアクセント選択ポップアップが表示されるのを無効にする
defaults write -g ApplePressAndHoldEnabled -bool false

# 入力補助系の無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable "Automatically rearrange spaces based on most recent use"
defaults write com.apple.dock 'mru-spaces' -bool false

# Dim hidden apps
defaults write com.apple.Dock showhidden -bool true

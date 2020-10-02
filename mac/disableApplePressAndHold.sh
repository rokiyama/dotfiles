#!/bin/sh

# US 入力モードでキー長押しでアクセント選択ポップアップが表示されるのを無効にする
defaults write -g ApplePressAndHoldEnabled -bool false

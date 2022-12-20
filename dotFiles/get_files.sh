git stash --include-untracked
cp -f ~/.tmux.conf ./dotFiles
git add --all dotFiles/* &&
git commit -m "New configuration files" || echo "No changes to commit"
git stash pop
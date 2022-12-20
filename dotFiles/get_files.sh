# Idea:
# https://github.com/hoop33/dotfiles/blob/main/setup.sh
env -i
echo "Stashing the files that may or may not have been added"
git stash --include-untracked

echo "Copying the files from home to here"
cp -f ~/.tmux.conf ./dotFiles

echo "Adding the files from ./dotFiles"
git add --all dotFiles/* dotFiles/.*

echo "Commiting the new files"
git commit -m "New configuration files"

echo "Recovering the work stashed"
git stash pop
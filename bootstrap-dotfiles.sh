#/bin/bash

# Preventive maintenance, so the bootstrap script can be executed multiple
# times without errors.
rm -f .dotfiles.git dotfiles.git

# Get the dotfiles repo
git clone --bare https://github.com/sputtene/dotfiles.git
mv dotfiles.git .dotfiles.git

mkdir dotfiles_files
mkdir dotfiles_tmp

pushd dotfiles_files

git --git-dir=../.dotfiles.git/ --work-tree=. status
git --git-dir=../.dotfiles.git/ --work-tree=. reset --hard

# Save already existing files before temporarily overwriting them with the
# corresponding files from the repo.
# These files will be restored later.
for file in $(find -type f); do
    if [ -e "../$file" ]; then
        echo Saving $file
        mkdir -p "../dotfiles_tmp/$(dirname $file)"
        cp "../$file" "../dotfiles_tmp/$file"
    fi
done

# Include files starting with a . in the expansion of *
shopt -s dotglob
# copy dotfiles from repo
cp -R ./* ../
# restore saved files
cp -R ../dotfiles_tmp/* ../

shopt -u dotglob

popd

rm -R dotfiles_files dotfiles_tmp

# Fetch submodules
git --git-dir=./.dotfiles.git/ --work-tree=. submodule update --init


# Load new aliases. The `git` command is aliased so it works with the dotfiles setup.
# Source the aliases file in every new shell too. If .bashrc has not yet been updated
# to the version pulled in by this script, the git command won't be properly aliased
# and dotfiles management will be a lot more difficult.
echo "source ~/.bash_aliases" >> ~/.bashrc
source .bash_aliases


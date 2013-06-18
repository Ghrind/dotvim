# Installation:

    git clone git://github.com/nelstrom/dotvim.git ~/.vim

## Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

## Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

# Bundle

## Install a new bundle:

     $ git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
     $ git add .
     $ git commit -m "Install Fugitive.vim bundle as a submodule."

## Update all bundles

     $ cd ..
     $ git submodule foreach git pull origin master

# To remove a submodule

  * Delete the relevant section from the .gitmodules file.
  * Delete the relevant section from .git/config.
  * Run git rm --cached path_to_submodule (no trailing slash).
  * Commit and delete the now untracked submodule files.

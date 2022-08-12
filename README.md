# nerdtree-visual-selection
This plugin requires [NERDTree](https://github.com/preservim/nerdtree) also to be installed. **nerdtree-visual-selection** defines key mappings that will work on nodes contained in a Visual selection in **NERDTree**.

## Installation

Use your favorite plugin manager to install this plugin. [vim-pathogen](https://github.com/tpope/vim-pathogen), [Vundle.vim](https://github.com/VundleVim/Vundle.vim), [vim-plug](https://github.com/junegunn/vim-plug), [neobundle.vim](https://github.com/Shougo/neobundle.vim), and [dein.vim](https://github.com/Shougo/dein.vim) are some of the more popular ones. A lengthy discussion of these and other managers can be found on [vi.stackexchange.com](https://vi.stackexchange.com/questions/388/what-is-the-difference-between-the-vim-plugin-managers).

If you have no favorite, or want to manage your plugins without 3rd-party dependencies, I recommend using Vim 8 packages, as described in Greg Hurrell's excellent Youtube video: [Vim screencast #75: Plugin managers](https://www.youtube.com/watch?v=X2_R3uxDN6g)

## Known Issue

There are two kinds of NERDTree:
* **TabTree** - Opened with `:NERDTree`, `:NERDTreeFocus`, `:NERDTreeFind`, or `:NERDTreeToggle`
* **WindowTree** - Opened with `vim .` or `:e .`, among others.

This plugin does not work with **WindowTree** type trees, because the first file opened by it causes the NERDTree to close, and the other files in the selection to fail to open. These commands are disabled, and an error message is printed, when trying to use them in the wrong type NERDTree.

## Configuration

By default, all operations ask to be confirmed with a `Yes/No/All/Cancel` prompt. `All` is a `Yes` answer, while `Cancel` is a `No`, for the remainder of the selection. Confirmation for the different operations can be turned off by setting the following aptly-named variables to `0` in your `.vimrc`.

* `g:nerdtree_vis_confirm_open`
* `g:nerdtree_vis_confirm_delete`
* `g:nerdtree_vis_confirm_copy`
* `g:nerdtree_vis_confirm_move`

A [mark](http://vimdoc.sourceforge.net/htmldoc/motion.html#mark-motions) is used to make your NERDTree's `Jump` mappings work while keeping your selection. By default the mark is on the `n` key, if you already use this key for a mark inside NERDTree you can change it via `g:nerdtree_vis_jumpmark`

## Mappings

Where applicable, those key mappings match up with NERDTree settings. If not defined in your `.vimrc`, their default values are used. The mappings are as follows:

NERDTree variable | default | Purpose
---|---|---
NERDTreeMapActivateNode | <kbd>o</kbd>  | Open selected files.
NERDTreeMapOpenSplit    | <kbd>i</kbd>  | Open selected files in horizontal splits.
NERDTreeMapOpenVSplit   | <kbd>s</kbd>  | Open selected files in vertical splits.
NERDTreeMapOpenInTab    | <kbd>t</kbd>  | Open selected files in tabs.
*n/a*                   | <kbd>d</kbd> | Delete selected files from disk. If open in Vim, they remain open.
*n/a*                   | <kbd>m</kbd>  | Move the selected files to another directory. If open in Vim, the buffer still points to its old location.
*n/a*                   | <kbd>c</kbd>  | Copy selected files to another directory.
NERDTreeMapJumpRoot        | <kbd>P</kbd>    | Jump to the tree root.
NERDTreeMapJumpParent      | <kbd>p</kbd>    | Jump to the parent node of the cursor node.
NERDTreeMapJumpFirstChild  | <kbd>K</kbd>    | Jump to the first child of the cursor node's parent.
NERDTreeMapJumpLastChild   | <kbd>J</kbd>    | Jump to the last child of the cursor node's parent.
NERDTreeMapJumpPrevSibling | <kbd>c-k</kbd>  | Jump to the previous sibling of the cursor node.
NERDTreeMapJumpNextSibling | <kbd>c-j</kbd>  | Jump to the next sibling of the cursor node.

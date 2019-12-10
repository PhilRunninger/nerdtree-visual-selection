# nerdtree-visual-selection
This plugin requires [NERDTree](https://github.com/scrooloose/nerdtree) also to be installed. **nerdtree-visual-selection** defines key mappings that will work on nodes contained in a Visual selection in **NERDTree**.

There are two kinds of NERDTree:
* **TabTree** - Opened with `:NERDTree`, `:NERDTreeFocus`, `:NERDTreeFind`, or `:NERDTreeToggle`
* **WindowTree** - Opened with `vim .` or `:e .`, among others.

This plugin does not work with **WindowTree** type trees, because the first file opened by it causes the NERDTree to close, and the other files in the selection to fail to open. So make sure you use the right commands to open NERDTree when using these mappings.

Where applicable, those keymappings match up with NERDTree settings. If not defined in the user's `.vimrc`, their default values are used. The mappings are as follows:

NERDTree variable | default | Purpose
---|---|---
NERDTreeMapActivateNode | **`o`**  | Open selected files.
NERDTreeMapOpenSplit    | **`i`**  | Open selected files in horizontal splits.
NERDTreeMapOpenVSplit   | **`s`**  | Open selected files in vertical splits.
NERDTreeMapOpenInTab    | **`t`**  | Open selected files in tabs.
*n/a*                   | **`dd`** | Delete selected files from disk. If open in Vim, they remain open.
*n/a*                   | **`m`**  | Move the selected files to another directory. If open in Vim, the buffer still points to its old location.
*n/a*                   | **`c`**  | Copy selected files to another directory.

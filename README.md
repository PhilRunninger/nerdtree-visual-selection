# nerdtree-visual-selection
This plugin requires [NERDTree](https://github.com/scrooloose/nerdtree) also to be installed. **nerdtree-visual-selection** defines key mappings that will work on nodes contained in a Visual selection in **NERDTree**. Where applicable, those keymappings match up with NERDTree settings. If not defined in the user's `.vimrc`, their default values are used. The mappings are as follows:

NERDTree variable | default | Purpose
---|---|---
NERDTreeMapActivateNode | `o`  | Open selected files.
NERDTreeMapOpenSplit    | `i`  | Open selected files in horizontal splits.
NERDTreeMapOpenVSplit   | `s`  | Open selected files in vertical splits.
NERDTreeMapOpenInTab    | `t`  | Open selected files in tabs.
*n/a*                   | `dd` | Delete selected files from disk. If open in Vim, they remain open.

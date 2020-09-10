execute "vnoremap <buffer> " . g:NERDTreeMapActivateNode . " :call <SID>ProcessSelection('Opening', '', function('NERDTree_Open', ['p']), '', 1, 1)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenSplit .    " :call <SID>ProcessSelection('Opening', '', function('NERDTree_Open', ['h']), '', 1, 1)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenVSplit .   " :call <SID>ProcessSelection('Opening', '', function('NERDTree_Open', ['v']), '', 1, 1)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenInTab .    " :call <SID>ProcessSelection('Opening', '', function('NERDTree_Open', ['t']), '', 1, 1)<CR>"
execute "vnoremap <buffer> dd :call <SID>ProcessSelection('Deleting', '', function('NERDTree_Delete'), '', 0, 1)<CR>"
execute "vnoremap <buffer> m :call <SID>ProcessSelection('Moving',  function('PRE_MoveOrCopy'), function('NERDTree_MoveOrCopy', ['Moving']), function('POST_MoveOrCopy'), 0, 1)<CR>"
execute "vnoremap <buffer> c :call <SID>ProcessSelection('Copying', function('PRE_MoveOrCopy'), function('NERDTree_MoveOrCopy', ['Copying']), function('POST_MoveOrCopy'), 0, 1)<CR>"

if exists("g:nerdtree_visual_selection")
    finish
endif
let g:nerdtree_visual_selection = 1

" --------------------------------------------------------------------------------
" Delete
function! NERDTree_Delete(node)
    call a:node.delete()
endfunction

" --------------------------------------------------------------------------------
" Open
function! NERDTree_Open(target, node)
    if !empty(a:node) && !a:node.path.isDirectory
        silent call a:node.open({'where':a:target,'stay':1,'keepopen':1})
    endif
endfunction

" --------------------------------------------------------------------------------
" Move or copy
function! PRE_MoveOrCopy()
    let node = g:NERDTreeFileNode.GetSelected()
    if !exists('s:destination')
        let s:destination = node.path.str()
        if !node.path.isDirectory
            let s:destination = fnamemodify(s:destination, ':p:h')
        endif
        let s:destination = input('Destination directory: ', s:destination, 'dir')
        if s:destination == ''
            unlet! s:destination
            return 0
        endif
        let s:destination .= (s:destination =~# nerdtree#slash().'$' ? '' : nerdtree#slash())
        if !isdirectory(s:destination)
            call mkdir(s:destination, 'p')
        endif
    endif
    return 1
endfunction

function! NERDTree_MoveOrCopy(operation, node)
    let l:destination = s:destination . fnamemodify(a:node.path.str(), ':t')
    if a:operation == 'Moving'
        call a:node.rename(l:destination)
    else
        call a:node.copy(l:destination)
    endif
endfunction

function! POST_MoveOrCopy()
    unlet! s:destination
endfunction

" --------------------------------------------------------------------------------
" Main Processor
function! s:ProcessSelection(action, setup, callback, cleanup, closeWhenDone, confirmEachNode) range
    if b:NERDTree.isWinTree()
        call nerdtree#echo("Command is unavailable. Open NERDTree with :NERDTree, :NERDTreeToggle, or :NERDTreeFocus instead.")
        return
    endif

    if type(a:setup) == v:t_func
        if !a:setup()
            return
        endif
    endif

    let l:response = 0
    let curLine = a:firstline
    while curLine <= a:lastline
        call cursor(curLine, 1)
        let node = g:NERDTreeFileNode.GetSelected()
        call nerdtree#echo(a:action . " " . node.path.str() . " (" . (curLine - a:firstline + 1) . " of " . (a:lastline - a:firstline + 1) . ")...")
        if a:confirmEachNode && l:response < 3
            let l:response = confirm("Are you sure? ", "&Yes\n&No\n&All\n&Cancel")
            if l:response == 0  " Make Escape behave like Cancel
                let l:response = 4
            endif
        endif
        if !a:confirmEachNode || l:response == 1 || l:response == 3
            call a:callback(node)
        endif
        let curLine += 1
    endwhile

    if type(a:cleanup) == v:t_func
        call a:cleanup()
    endif

    let g:NERDTreeOldSortOrder = []
    call b:NERDTree.root.refresh()
    call NERDTreeRender()

    if g:NERDTreeQuitOnOpen && a:closeWhenDone
        NERDTreeClose
    endif

    call nerdtree#echo("")
endfunction

execute "vnoremap <buffer> " . g:NERDTreeMapActivateNode . " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['p']), 1, 0)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenSplit .    " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['h']), 1, 0)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenVSplit .   " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['v']), 1, 0)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenInTab .    " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['t']), 1, 0)<CR>"
execute "vnoremap <buffer> dd :call <SID>ProcessSelection('Deleting', function('NERDTree_Delete'), 0, 1)<CR>"
execute "vnoremap <buffer> m :call <SID>ProcessSelection('Moving', function('NERDTree_MoveOrCopy', ['Moving']), 0, 1)<CR>"
execute "vnoremap <buffer> c :call <SID>ProcessSelection('Copying', function('NERDTree_MoveOrCopy', ['Copying']), 0, 1)<CR>"

function! NERDTree_Delete(node)
    call a:node.delete()
endfunction

function! NERDTree_Open(target, node)
    if !empty(a:node) && !a:node.path.isDirectory
        silent call a:node.open({'where':a:target,'stay':1,'keepopen':1})
    endif
endfunction

function! NERDTree_MoveOrCopy(operation, node)
    if !exists('s:destination')
        let s:destination = a:node.path.str()
        if !a:node.path.isDirectory
            let s:destination = fnamemodify(s:destination, ':p:h')
        endif
        let s:destination = input('Destination directory: ', s:destination, 'dir')
        let s:destination .= (s:destination =~# nerdtree#slash().'$' ? '' : nerdtree#slash())
        if !isdirectory(s:destination)
            call mkdir(s:destination, 'p')
        endif
    endif
    let l:destination = s:destination . fnamemodify(a:node.path.str(), ':p:t')
    if a:operation == 'Moving'
        call a:node.rename(l:destination)
    else
        call a:node.copy(l:destination)
    endif
endfunction

function! s:ProcessSelection(action, callback, closeWhenDone, confirmEachNode) range
    if b:NERDTree.isWinTree()
        echomsg "Command is unavailable. Open NERDTree with :NERDTree, :NERDTreeToggle, or :NERDTreeFocus instead."
        return
    endif

    let l:response = 0
    let curLine = a:firstline
    while curLine <= a:lastline
        call cursor(curLine, 1)
        let node = g:NERDTreeFileNode.GetSelected()
        call nerdtree#echo(a:action . " " . node.path.str() . " (" . (curLine - a:firstline + 1) . " of " . (a:lastline - a:firstline + 1) . ")...")
        if a:confirmEachNode && l:response < 3
            let l:response = confirm("Are you sure? ", "&Yes\n&No\n&All\n&Cancel")
        endif
        if !a:confirmEachNode || l:response % 2 == 1
            call a:callback(node)
        endif
        let curLine += 1
    endwhile

    let g:NERDTreeOldSortOrder = []
    call b:NERDTree.root.refresh()
    call NERDTreeRender()
    unlet! s:destination
    if a:action == 'Moving'
        echomsg "Check your buffers for files that have been renamed."
    endif

    if g:NERDTreeQuitOnOpen && a:closeWhenDone
        NERDTreeClose
    endif

    call nerdtree#echo("")
endfunction

execute "vnoremap <buffer> " . g:NERDTreeMapActivateNode . " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['p']), 1, 0)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenSplit .    " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['h']), 1, 0)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenVSplit .   " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['v']), 1, 0)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenInTab .    " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['t']), 1, 0)<CR>"
execute "vnoremap <buffer> dd :call <SID>ProcessSelection('Deleting', function('NERDTree_Delete'), 0, 1)<CR>"

function! NERDTree_Delete(node)
    call a:node.delete()
endfunction

function! NERDTree_Open(target, node)
    if !empty(a:node) && !a:node.path.isDirectory
        silent call a:node.open({'where':a:target,'stay':1,'keepopen':1})
    endif
endfunction

function! s:ProcessSelection(action, callback, closeWhenDone, confirmEachNode) range
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

    call NERDTreeRender()
    if g:NERDTreeQuitOnOpen && a:closeWhenDone
        NERDTreeClose
    endif

    call nerdtree#echo("")
endfunction

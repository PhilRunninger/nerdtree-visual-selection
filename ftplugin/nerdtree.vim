execute "vnoremap <buffer> " . g:NERDTreeMapActivateNode . " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['p']), 1)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenSplit .    " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['h']), 1)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenVSplit .   " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['v']), 1)<CR>"
execute "vnoremap <buffer> " . g:NERDTreeMapOpenInTab .    " :call <SID>ProcessSelection('Opening', function('NERDTree_Open', ['t']), 1)<CR>"
execute "vnoremap <buffer> dd :call <SID>ProcessSelection('Deleting', function('NERDTree_Delete'), 0)<CR>"

function! NERDTree_Delete(node)
    if s:response < 3
        let s:response = confirm("Delete " . a:node.path.str() . "?", "&Yes\n&No\n&All\n&Cancel")
    endif
    if s:response == 1 || s:response == 3
        call a:node.delete()
    endif
endfunction

function! NERDTree_Open(target, node)
    if !empty(a:node) && !a:node.path.isDirectory
        silent call a:node.open({'where':a:target,'stay':1,'keepopen':1})
    endif
endfunction

function! s:ProcessSelection(action, callback, closeWhenDone) range
    let s:response = 0
    let curLine = a:firstline
    while curLine <= a:lastline
        call nerdtree#echo(a:action . " " . (curLine - a:firstline + 1) . " of " . (a:lastline - a:firstline + 1) . "...")
        call cursor(curLine, 1)
        let node = g:NERDTreeFileNode.GetSelected()
        call a:callback(node)
        let curLine += 1
    endwhile
    call NERDTreeRender()
    if g:NERDTreeQuitOnOpen && a:closeWhenDone
        NERDTreeClose
    endif
    call nerdtree#echo("")
endfunction

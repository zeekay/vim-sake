command! -bang -nargs=* -complete=customlist,sake#Complete Sake call sake#Task("<bang>", <f-args>)
cabbrev sake <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Sake' : 'sake')<CR>

" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.json		setfiletype json
  au! BufRead,BufNewFile *.json		setfiletype json
augroup END


set tabstop=4		    "An indentation level every four columns"
set expandtab		    "Convert all tabs typed into spaces"
set shiftwidth=4	    "Indent/outdent by four columns"
set shiftround		    "Always indent/outdent to the nearest tabstop"
set softtabstop=4

""" Additions to standart syntax
syntax sync fromstart

""" Include perl inside html and detach it's highlights from html's
if version < 600
  syn include @ICGIperl <sfile>:p:h/icgiperl.vim
else
  unlet b:current_syntax
  syn include @ICGIperl syntax/icgiperl.vim
  let b:current_syntax="html"
endif
syn region  ICGIPerlBlock	keepend matchgroup=ICGIDelimiter start=+<!--&+ end=+-->+  contains=@ICGIperl
syn region  ICGIPerlBlock	keepend matchgroup=ICGIDelimiter start=+@\~+   end=+\~@+  contains=@ICGIperl
syn region  ICGIPerlBlock	keepend matchgroup=ICGIDelimiter start=+\^\~+  end=+\~\^+ contains=@ICGIperl
syn region  ICGIPerlBlock	keepend matchgroup=ICGIDelimiter start=+#\~+   end=+\~#+  contains=@ICGIperl
syn cluster htmlPreproc		add=ICGIPerlBlock
hi! def link icgiperlFunction         ONLYicgiperlIdentifier
hi! def link icgiperlIdentifier       ONLYicgiperlIdentifier
hi! def link icgiperlConditional      ONLYicgiperlStatement
hi! def link icgiperlLabel            ONLYicgiperlStatement
hi! def link icgiperlOperator         ONLYicgiperlStatement
hi! def link icgiperlRepeat           ONLYicgiperlStatement
hi! def link icgiperlStatement        ONLYicgiperlStatement
hi! def link icgiperlCharacter        ONLYicgiperlConstant
hi! def link icgiperlFloat            ONLYicgiperlConstant
hi! def link icgiperlNumber           ONLYicgiperlConstant
hi! def link icgiperlString           ONLYicgiperlConstant
hi! def link icgiperlControl          ONLYicgiperlPreProc
hi! def link icgiperlInclude          ONLYicgiperlPreProc
hi! def link icgiperlSharpBang        ONLYicgiperlPreProc
hi! def link icgiperlBrackets         ONLYicgiperlError
hi! def link icgiperlElseIfError      ONLYicgiperlError
hi! def link icgiperlNotEmptyLine     ONLYicgiperlError
hi! def link icgiperlVarComma	      ICGIPerlBlock
hi! def link icgiperlVarMember	      ICGIPerlBlock
hi! def link icgiperlVarBlock	      ICGIPerlBlock
hi! def link icgiperlVarCurlyBlock    ICGIPerlBlock

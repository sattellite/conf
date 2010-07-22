set tabstop=4		    "An indentation level every four columns"
set expandtab		    "Convert all tabs typed into spaces"
set shiftwidth=4	    "Indent/outdent by four columns"
set shiftround		    "Always indent/outdent to the nearest tabstop"
set softtabstop=4

""" Bugfixes for standart syntax
"   m||	    s|||    qr!!    qr[]
syn region perlMatch	matchgroup=perlMatchStartEnd start=+[m!]|+ end=+|[cgimosx]*+ contains=@perlInterpMatch
syn region perlMatch	matchgroup=perlMatchStartEnd start=+\<s|+  end=+|+me=e-1 contains=@perlInterpMatch nextgroup=perlSubstitutionPipe
syn region perlSubstitutionPipe		matchgroup=perlMatchStartEnd start=+|+  end=+|[ecgimosx]*+ contained contains=@perlInterpDQ
hi def link perlSubstitutionPipe perlString
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr!+  end=+![imosx]*+  contains=@perlInterpMatch
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr\[+ end=+\][imosx]*+ contains=@perlInterpMatch
" perlStringStartEnd -> perlMatchStartEnd
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr#+  end=+#[imosx]*+ contains=@perlInterpMatch
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr|+  end=+|[imosx]*+ contains=@perlInterpMatch
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr(+  end=+)[imosx]*+ contains=@perlInterpMatch
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr{+  end=+}[imosx]*+ contains=@perlInterpMatch
syn region perlQQ		matchgroup=perlMatchStartEnd start=+\<qr/+  end=+/[imosx]*+ contains=@perlInterpSlash
" add slices @Q{a,b} and internal blocks %{ {...} } support to extended_vars
syn match  perlVarComma		"\%(\_s\|,\)\+" contained
syn region perlVarCurlyBlock	start=+{+ end=+}+ contained contains=@perlExpr
syn cluster perlExpr		contains=perlVarComma,perlVarCurlyBlock,perlVarSimpleMemberName,perlStatementScalar,perlStatementRegexp,perlStatementNumeric,perlStatementList,perlStatementHash,perlStatementFiles,perlStatementTime,perlStatementMisc,perlVarPlain,perlVarNotInMatches,perlVarSlash,perlVarBlock,perlShellCommand,perlFloat,perlNumber,perlStringUnexpanded,perlString,perlQQ
" allow numbers in simple cases $Q{12} $Q[12]
syn match  perlVarSimpleMember	"\(->\)\={\i\+}"    nextgroup=perlVarMember,perlVarSimpleMember contains=perlVarSimpleMemberName contained
syn match  perlVarSimpleMember	"\(->\)\=\[\d\+\]"  nextgroup=perlVarMember,perlVarSimpleMember contains=perlVarSimpleMemberName contained
" added highlight for logical not: !
syn match perlNOT		"\([$@%]\@<!\)!\([~=]\@!\)"

""" Additions to standart syntax
syn match  perlComment          "#.*" contains=@Spell,perlTodo
"syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Spell
syn keyword perlTodo	BUG WARNING DEBUG OPTIMIZATION WORKAROUND contained
syntax sync fromstart


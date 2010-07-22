set tabstop=4		    "An indentation level every four columns"
set expandtab		    "Convert all tabs typed into spaces"
set shiftwidth=4	    "Indent/outdent by four columns"
set shiftround		    "Always indent/outdent to the nearest tabstop"
set softtabstop=4

""" Bugfixes for standart syntax
"   m||	    s|||    qr!!    qr[]
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+[m!]|+ end=+|[cgimosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s|+  end=+|+me=e-1 contains=@icgiperlInterpMatch nextgroup=icgiperlSubstitutionPipe
syn region icgiperlSubstitutionPipe		matchgroup=icgiperlMatchStartEnd start=+|+  end=+|[ecgimosx]*+ contained contains=@icgiperlInterpDQ
hi def link icgiperlSubstitutionPipe icgiperlString
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr!+  end=+![imosx]*+  contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr\[+ end=+\][imosx]*+ contains=@icgiperlInterpMatch
" icgiperlStringStartEnd -> icgiperlMatchStartEnd
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr#+  end=+#[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr|+  end=+|[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr(+  end=+)[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr{+  end=+}[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlMatchStartEnd start=+\<qr/+  end=+/[imosx]*+ contains=@icgiperlInterpSlash
" add slices @Q{a,b} and internal blocks %{ {...} } support to extended_vars
syn match  icgiperlVarComma		"\%(\_s\|,\)\+" contained
syn region icgiperlVarCurlyBlock	start=+{+ end=+}+ contained contains=@icgiperlExpr
syn cluster icgiperlExpr		contains=icgiperlVarComma,icgiperlVarCurlyBlock,icgiperlVarSimpleMemberName,icgiperlStatementScalar,icgiperlStatementRegexp,icgiperlStatementNumeric,icgiperlStatementList,icgiperlStatementHash,icgiperlStatementFiles,icgiperlStatementTime,icgiperlStatementMisc,icgiperlVarPlain,icgiperlVarNotInMatches,icgiperlVarSlash,icgiperlVarBlock,icgiperlShellCommand,icgiperlFloat,icgiperlNumber,icgiperlStringUnexpanded,icgiperlString,icgiperlQQ
" allow numbers in simple cases $Q{12} $Q[12]
syn match  icgiperlVarSimpleMember	"\(->\)\={\i\+}"    nextgroup=icgiperlVarMember,icgiperlVarSimpleMember contains=icgiperlVarSimpleMemberName contained
syn match  icgiperlVarSimpleMember	"\(->\)\=\[\d\+\]"  nextgroup=icgiperlVarMember,icgiperlVarSimpleMember contains=icgiperlVarSimpleMemberName contained
" added highlight for logical not: !
syn match icgiperlNOT		"\([$@%]\@<!\)!\([~=]\@!\)"

""" Additions to standart syntax
syn keyword icgiperlTodo	BUG WARNING DEBUG OPTIMIZATION WORKAROUND contained
syntax sync fromstart


" Vim syntax file
" Language:	icgiPerl
" Maintainer:	Nick Hibma <n_hibma@van-laarhoven.org>
" Last Change:	2005 October 18
" Location:	http://www.van-laarhoven.org/vim/syntax/icgiperl.vim
"
" Please download most recent version first before mailing
" any comments.
" See also the file icgiperl.vim.regression.pl to check whether your
" modifications work in the most odd cases
" http://www.van-laarhoven.org/vim/syntax/icgiperl.vim.regression.pl
"
" Original version: Sonia Heimann <niania@netsurf.org>
" Thanks to many people for their contribution.

" The following parameters are available for tuning the
" icgiperl syntax highlighting, with defaults given:
"
" unlet icgiperl_include_pod
" unlet icgiperl_no_scope_in_variables
" unlet icgiperl_no_extended_vars
" unlet icgiperl_string_as_statement
" unlet icgiperl_no_sync_on_sub
" unlet icgiperl_no_sync_on_global_var
" let icgiperl_sync_dist = 100
" unlet icgiperl_fold
" unlet icgiperl_fold_blocks

" Remove any old syntax stuff that was loaded (5.x) or quit when a syntax file
" was already loaded (6.x).
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Unset icgiperl_fold if it set but vim doesn't support it.
if version < 600 && exists("icgiperl_fold")
  unlet icgiperl_fold
endif


" POD starts with ^=<word> and ends with ^=cut

if exists("icgiperl_include_pod")
  " Include a while extra syntax file
  syn include @Pod syntax/pod.vim
  unlet b:current_syntax
  if exists("icgiperl_fold")
    syn region icgiperlPOD start="^=[a-z]" end="^=cut" contains=@Pod,@Spell,icgiperlTodo keepend fold
    syn region icgiperlPOD start="^=cut" end="^=cut" contains=icgiperlTodo keepend fold
  else
    syn region icgiperlPOD start="^=[a-z]" end="^=cut" contains=@Pod,@Spell,icgiperlTodo keepend
    syn region icgiperlPOD start="^=cut" end="^=cut" contains=icgiperlTodo keepend
  endif
else
  " Use only the bare minimum of rules
  if exists("icgiperl_fold")
    syn region icgiperlPOD start="^=[a-z]" end="^=cut" contains=@Spell fold
  else
    syn region icgiperlPOD start="^=[a-z]" end="^=cut" contains=@Spell
  endif
endif


" All keywords
"
if exists("icgiperl_fold") && exists("icgiperl_fold_blocks")
  syn match icgiperlConditional		"\<if\>"
  syn match icgiperlConditional		"\<elsif\>"
  syn match icgiperlConditional		"\<unless\>"
  syn match icgiperlConditional		"\<else\>" nextgroup=icgiperlElseIfError skipwhite skipnl skipempty
else
  syn keyword icgiperlConditional		if elsif unless
  syn keyword icgiperlConditional		else nextgroup=icgiperlElseIfError skipwhite skipnl skipempty
endif
syn keyword icgiperlConditional		switch eq ne gt lt ge le cmp not and or xor err
if exists("icgiperl_fold") && exists("icgiperl_fold_blocks")
  syn match icgiperlRepeat			"\<while\>"
  syn match icgiperlRepeat			"\<for\>"
  syn match icgiperlRepeat			"\<foreach\>"
  syn match icgiperlRepeat			"\<do\>"
  syn match icgiperlRepeat			"\<until\>"
  syn match icgiperlRepeat			"\<continue\>"
else
  syn keyword icgiperlRepeat		while for foreach do until continue
endif
syn keyword icgiperlOperator		defined undef and or not bless ref
if exists("icgiperl_fold")
  " if BEGIN/END is a keyword the icgiperlBEGINENDFold does not work
  syn match icgiperlControl			"\<BEGIN\|END\|CHECK\|INIT\>" contained
else
  syn keyword icgiperlControl		BEGIN END CHECK INIT
endif

syn keyword icgiperlStatementStorage	my local our
syn keyword icgiperlStatementControl	goto return last next redo
syn keyword icgiperlStatementScalar		chomp chop chr crypt index lc lcfirst length ord pack reverse rindex sprintf substr uc ucfirst
syn keyword icgiperlStatementRegexp		pos quotemeta split study
syn keyword icgiperlStatementNumeric	abs atan2 cos exp hex int log oct rand sin sqrt srand
syn keyword icgiperlStatementList		splice unshift shift push pop split join reverse grep map sort unpack
syn keyword icgiperlStatementHash		each exists keys values tie tied untie
syn keyword icgiperlStatementIOfunc		carp confess croak dbmclose dbmopen die syscall
syn keyword icgiperlStatementFiledesc	binmode close closedir eof fileno getc lstat print printf readdir readline readpipe rewinddir select stat tell telldir write nextgroup=icgiperlFiledescStatementNocomma skipwhite
syn keyword icgiperlStatementFiledesc	fcntl flock ioctl open opendir read seek seekdir sysopen sysread sysseek syswrite truncate nextgroup=icgiperlFiledescStatementComma skipwhite
syn keyword icgiperlStatementVector		pack vec
syn keyword icgiperlStatementFiles		chdir chmod chown chroot glob link mkdir readlink rename rmdir symlink umask unlink utime
syn match   icgiperlStatementFiles		"-[rwxoRWXOezsfdlpSbctugkTBMAC]\>"
syn keyword icgiperlStatementFlow		caller die dump eval exit wantarray
syn keyword icgiperlStatementInclude	require
syn match   icgiperlStatementInclude	"\<\(use\|no\)\s\+\(\(attributes\|autouse\|base\|big\(int\|num\|rat\)\|blib\|bytes\|charnames\|constant\|diagnostics\|encoding\|fields\|filetest\|if\|integer\|less\|lib\|locale\|open\|ops\|overload\|re\|sigtrap\|sort\|strict\|subs\|threads\(::shared\)\=\|utf8\|vars\|vmsish\|warnings\(::register\)\=\)\>\)\="

syn keyword icgiperlStatementProc		alarm exec fork getpgrp getppid getpriority kill pipe setpgrp setpriority sleep system times wait waitpid
syn keyword icgiperlStatementSocket		accept bind connect getpeername getsockname getsockopt listen recv send setsockopt shutdown socket socketpair
syn keyword icgiperlStatementIPC		msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite
syn keyword icgiperlStatementNetwork	endhostent endnetent endprotoent endservent gethostbyaddr gethostbyname gethostent getnetbyaddr getnetbyname getnetent getprotobyname getprotobynumber getprotoent getservbyname getservbyport getservent sethostent setnetent setprotoent setservent
syn keyword icgiperlStatementPword		getpwuid getpwnam getpwent setpwent endpwent getgrent getgrgid getlogin getgrnam setgrent endgrent
syn keyword icgiperlStatementTime		gmtime localtime time times

syn keyword icgiperlStatementMisc		warn formline reset scalar delete prototype lock
if !exists("icgiperl_no_semi_keywords")
  syn keyword icgiperlStatementScope	import
  syn keyword icgiperlStatementNew		new
  syn keyword icgiperlStatementCarp		carp confess croak 		
endif
syn keyword icgiperlTodo			TODO TBD FIXME XXX contained

" icgiPerl Identifiers.
"
" Should be cleaned up to better handle identifiers in particular situations
" (in hash keys for example)
"
" Plain identifiers: $foo, @foo, $#foo, %foo, &foo and dereferences $$foo, @$foo, etc.
" We do not process complex things such as @{${"foo"}}. Too complicated, and
" too slow. And what is after the -> is *not* considered as part of the
" variable - there again, too complicated and too slow.

" Special variables first ($^A, ...) and ($|, $', ...)
syn match  icgiperlVarPlain		 "$^[ADEFHILMOPSTWX]\="
syn match  icgiperlVarPlain		 "$[\\\"\[\]'&`+*.,;=%~?@$<>(-]"
syn match  icgiperlVarPlain		 "$\(0\|[1-9]\d*\)"
" Same as above, but avoids confusion in $::foo (equivalent to $main::foo)
syn match  icgiperlVarPlain		 "$:[^:]"
" These variables are not recognized within matches.
syn match  icgiperlVarNotInMatches	 "$[|)]"
" This variable is not recognized within matches delimited by '/'.
syn match  icgiperlVarSlash		 "$/"
" This variable is not recognized within matches delimited by '!'.
syn match  icgiperlVarBang		 "$!"

" And plain identifiers
syn match  icgiperlPackageRef	 "\(\h\w*\)\=\(::\|'\)\I"me=e-1 contained

" FIXME value between {} should be marked as string. is treated as such by icgiPerl.
" At the moment it is marked as something greyish instead of read. Probably todo
" with transparency. Or maybe we should handle the bare word in that case. or make it into

if !exists("icgiperl_no_scope_in_variables")
  syn match  icgiperlVarPlain	"\\\=\([@%$]\|\$#\)\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" contains=icgiperlPackageRef nextgroup=icgiperlVarMember,icgiperlVarSimpleMember,icgiperlMethod
  syn match  icgiperlFunctionName	"\\\=&\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" contains=icgiperlPackageRef nextgroup=icgiperlVarMember,icgiperlVarSimpleMember
else
  syn match  icgiperlVarPlain	"\\\=\([@%$]\|\$#\)\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" nextgroup=icgiperlVarMember,icgiperlVarSimpleMember,icgiperlMethod
  syn match  icgiperlFunctionName	"\\\=&\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" nextgroup=icgiperlVarMember,icgiperlVarSimpleMember
endif

if !exists("icgiperl_no_extended_vars")
  syn cluster icgiperlExpr		contains=icgiperlStatementScalar,icgiperlStatementRegexp,icgiperlStatementNumeric,icgiperlStatementList,icgiperlStatementHash,icgiperlStatementFiles,icgiperlStatementTime,icgiperlStatementMisc,icgiperlVarPlain,icgiperlVarNotInMatches,icgiperlVarSlash,icgiperlVarBang,icgiperlVarBlock,icgiperlShellCommand,icgiperlFloat,icgiperlNumber,icgiperlStringUnexpanded,icgiperlString,icgiperlQQ
  syn region icgiperlVarBlock	matchgroup=icgiperlVarPlain start="\($#\|[@%$]\)\$*{" skip="\\}" end="}" contains=@icgiperlExpr nextgroup=icgiperlVarMember,icgiperlVarSimpleMember
  syn region icgiperlVarBlock	matchgroup=icgiperlVarPlain start="&\$*{" skip="\\}" end="}" contains=@icgiperlExpr
  syn match  icgiperlVarPlain	"\\\=\(\$#\|[@%&$]\)\$*{\I\i*}" nextgroup=icgiperlVarMember,icgiperlVarSimpleMember
  syn region icgiperlVarMember	matchgroup=icgiperlVarPlain start="\(->\)\={" skip="\\}" end="}" contained contains=@icgiperlExpr nextgroup=icgiperlVarMember,icgiperlVarSimpleMember
  syn match  icgiperlVarSimpleMember	"\(->\)\={\I\i*}" nextgroup=icgiperlVarMember,icgiperlVarSimpleMember contains=icgiperlVarSimpleMemberName contained
  syn match  icgiperlVarSimpleMemberName	"\I\i*" contained
  syn region icgiperlVarMember	matchgroup=icgiperlVarPlain start="\(->\)\=\[" skip="\\]" end="]" contained contains=@icgiperlExpr nextgroup=icgiperlVarMember,icgiperlVarSimpleMember
  syn match  icgiperlMethod		"\(->\)\I\i*" contained
endif

" File Descriptors
syn match  icgiperlFiledescRead	"[<]\h\w\+[>]"

syn match  icgiperlFiledescStatementComma	"(\=\s*\u\w*\s*,"me=e-1 transparent contained contains=icgiperlFiledescStatement
syn match  icgiperlFiledescStatementNocomma "(\=\s*\u\w*\s*[^,[:space:]]"me=e-1 transparent contained contains=icgiperlFiledescStatement

syn match  icgiperlFiledescStatement	"\u\w*" contained

" Special characters in strings and matches
syn match  icgiperlSpecialString	"\\\(\d\+\|[xX]\x\+\|c\u\|.\)" contained
syn match  icgiperlSpecialStringU	"\\['\\]" contained
syn match  icgiperlSpecialMatch	"{\d\+\(,\d*\)\=}" contained
syn match  icgiperlSpecialMatch	"\[\(\]\|-\)\=[^\[\]]*\(\[\|\-\)\=\]" contained
syn match  icgiperlSpecialMatch	"[+*()?.]" contained
syn match  icgiperlSpecialMatch	"(?[#:=!]" contained
syn match  icgiperlSpecialMatch	"(?<[=!]" contained
syn match  icgiperlSpecialMatch	"(?[imsx]\+)" contained
" FIXME the line below does not work. It should mark end of line and
" begin of line as icgiperlSpecial.
" syn match icgiperlSpecialBEOM    "^\^\|\$$" contained

" Possible errors
"
" Highlight lines with only whitespace (only in blank delimited here documents) as errors
syn match  icgiperlNotEmptyLine	"^\s\+$" contained
" Highlight '} else if (...) {', it should be '} else { if (...) { ' or
" '} elsif (...) {'.
"syn keyword icgiperlElseIfError	if contained

" Variable interpolation
"
" These items are interpolated inside "" strings and similar constructs.
syn cluster icgiperlInterpDQ	contains=icgiperlSpecialString,icgiperlVarPlain,icgiperlVarNotInMatches,icgiperlVarSlash,icgiperlVarBang,icgiperlVarBlock
" These items are interpolated inside '' strings and similar constructs.
syn cluster icgiperlInterpSQ	contains=icgiperlSpecialStringU
" These items are interpolated inside m// matches and s/// substitutions.
syn cluster icgiperlInterpSlash	contains=icgiperlSpecialString,icgiperlSpecialMatch,icgiperlVarPlain,icgiperlVarBlock,icgiperlSpecialBEOM
" These items are interpolated inside m## matches and s### substitutions.
syn cluster icgiperlInterpMatch	contains=@icgiperlInterpSlash,icgiperlVarSlash,icgiperlVarBang

" Shell commands
syn region  icgiperlShellCommand	matchgroup=icgiperlMatchStartEnd start="`" end="`" contains=@icgiperlInterpDQ

" Constants
"
" Numbers
syn match  icgiperlNumber	"[-+]\=\(\<\d[[:digit:]_]*L\=\>\|0[xX]\x[[:xdigit:]_]*\>\)"
syn match  icgiperlFloat	"[-+]\=\<\d[[:digit:]_]*[eE][\-+]\=\d\+"
syn match  icgiperlFloat	"[-+]\=\<\d[[:digit:]_]*\.[[:digit:]_]*\([eE][\-+]\=\d\+\)\="
syn match  icgiperlFloat	"[-+]\=\<\.[[:digit:]_]\+\([eE][\-+]\=\d\+\)\="


" Simple version of searches and matches
" caters for m//, m##, m{} and m[] (and the !/ variant)
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+[m!]/+ end=+/[cgimosx]*+ contains=@icgiperlInterpSlash
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+[m!]#+ end=+#[cgimosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+[m!]{+ end=+}[cgimosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+[m!]\[+ end=+\][cgimosx]*+ contains=@icgiperlInterpMatch

" A special case for m!!x which allows for comments and extra whitespace in the pattern
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+[m!]!+ end=+![cgimosx]*+ contains=@icgiperlInterpSlash,icgiperlComment

" Below some hacks to recognise the // variant. This is virtually impossible to catch in all
" cases as the / is used in so many other ways, but these should be the most obvious ones.
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+^split /+lc=5 start=+[^$@%&]\<split /+lc=6 start=+^while /+lc=5 start=+[^$@%&]while /+lc=6 start=+^if /+lc=2 start=+[^$@%&]if /+lc=3 start=+[!=]\~\s*/+lc=2 start=+[(~]/+lc=1 start=+\.\./+lc=2 start=+\s/[^=[:space:][:digit:]$@%&]+lc=1,me=e-1,rs=e-1 start=+^/+ skip=+\\/+ end=+/[cgimosx]*+ contains=@icgiperlInterpSlash


" Substitutions
" caters for s///, s### and s[][]
" icgiperlMatch is the first part, icgiperlSubstitution* is the substitution part
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s'+  end=+'+me=e-1 contains=@icgiperlInterpSQ nextgroup=icgiperlSubstitutionSQ
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s"+  end=+"+me=e-1 contains=@icgiperlInterpMatch nextgroup=icgiperlSubstitutionDQ
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s/+  end=+/+me=e-1 contains=@icgiperlInterpSlash nextgroup=icgiperlSubstitutionSlash
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s#+  end=+#+me=e-1 contains=@icgiperlInterpMatch nextgroup=icgiperlSubstitutionHash
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s\[+ end=+\]+ contains=@icgiperlInterpMatch nextgroup=icgiperlSubstitutionBracket skipwhite skipempty skipnl
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s{+ end=+}+ contains=@icgiperlInterpMatch nextgroup=icgiperlSubstitutionCurly skipwhite skipempty skipnl
syn region icgiperlSubstitutionSQ		matchgroup=icgiperlMatchStartEnd start=+'+  end=+'[ecgimosx]*+ contained contains=@icgiperlInterpSQ
syn region icgiperlSubstitutionDQ		matchgroup=icgiperlMatchStartEnd start=+"+  end=+"[ecgimosx]*+ contained contains=@icgiperlInterpDQ
syn region icgiperlSubstitutionSlash	matchgroup=icgiperlMatchStartEnd start=+/+  end=+/[ecgimosx]*+ contained contains=@icgiperlInterpDQ
syn region icgiperlSubstitutionHash		matchgroup=icgiperlMatchStartEnd start=+#+  end=+#[ecgimosx]*+ contained contains=@icgiperlInterpDQ
syn region icgiperlSubstitutionBracket	matchgroup=icgiperlMatchStartEnd start=+\[+ end=+\][ecgimosx]*+ contained contains=@icgiperlInterpDQ
syn region icgiperlSubstitutionCurly	matchgroup=icgiperlMatchStartEnd start=+{+  end=+}[ecgimosx]*+ contained contains=@icgiperlInterpDQ

" A special case for s!!!x which allows for comments and extra whitespace in the pattern
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<s!+ end=+!+me=e-1 contains=@icgiperlInterpSlash,icgiperlComment nextgroup=icgiperlSubstitutionPling
syn region icgiperlSubstitutionPling	matchgroup=icgiperlMatchStartEnd start=+!+ end=+![ecgimosx]*+ contained contains=@icgiperlInterpDQ

" Substitutions
" caters for tr///, tr### and tr[][]
" icgiperlMatch is the first part, icgiperlTranslation* is the second, translator part.
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<\(tr\|y\)'+ end=+'+me=e-1 contains=@icgiperlInterpSQ nextgroup=icgiperlTranslationSQ
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<\(tr\|y\)"+ end=+"+me=e-1 contains=@icgiperlInterpSQ nextgroup=icgiperlTranslationDQ
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<\(tr\|y\)/+ end=+/+me=e-1 contains=@icgiperlInterpSQ nextgroup=icgiperlTranslationSlash
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<\(tr\|y\)#+ end=+#+me=e-1 contains=@icgiperlInterpSQ nextgroup=icgiperlTranslationHash
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<\(tr\|y\)\[+ end=+\]+ contains=@icgiperlInterpSQ nextgroup=icgiperlTranslationBracket skipwhite skipempty skipnl
syn region icgiperlMatch	matchgroup=icgiperlMatchStartEnd start=+\<\(tr\|y\){+ end=+}+ contains=@icgiperlInterpSQ nextgroup=icgiperlTranslationCurly skipwhite skipempty skipnl
syn region icgiperlTranslationSQ		matchgroup=icgiperlMatchStartEnd start=+'+ end=+'[cds]*+ contained
syn region icgiperlTranslationDQ		matchgroup=icgiperlMatchStartEnd start=+"+ end=+"[cds]*+ contained
syn region icgiperlTranslationSlash		matchgroup=icgiperlMatchStartEnd start=+/+ end=+/[cds]*+ contained
syn region icgiperlTranslationHash		matchgroup=icgiperlMatchStartEnd start=+#+ end=+#[cds]*+ contained
syn region icgiperlTranslationBracket	matchgroup=icgiperlMatchStartEnd start=+\[+ end=+\][cds]*+ contained
syn region icgiperlTranslationCurly		matchgroup=icgiperlMatchStartEnd start=+{+ end=+}[cds]*+ contained


" The => operator forces a bareword to the left of it to be interpreted as
" a string
syn match  icgiperlString "\<\I\i*\s*=>"me=e-2

" Strings and q, qq, qw and qr expressions

" Parentheses in qq()
syn region icgiperlParens	start=+(+ end=+)+ contained transparent contains=icgiperlParens,@icgiperlStringSQ

syn region icgiperlStringUnexpanded	matchgroup=icgiperlStringStartEnd start="'" end="'" contains=@Spell,@icgiperlInterpSQ
syn region icgiperlString		matchgroup=icgiperlStringStartEnd start=+"+  end=+"+ contains=@Spell,@icgiperlInterpDQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q#+ end=+#+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q|+ end=+|+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q(+ end=+)+ contains=@icgiperlInterpSQ,icgiperlParens
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q{+ end=+}+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q/+ end=+/+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q[qx]#+ end=+#+ contains=@icgiperlInterpDQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q[qx]|+ end=+|+ contains=@icgiperlInterpDQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q[qx](+ end=+)+ contains=@icgiperlInterpDQ,icgiperlParens
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q[qx]{+ end=+}+ contains=@icgiperlInterpDQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<q[qx]/+ end=+/+ contains=@icgiperlInterpDQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qw#+  end=+#+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qw|+  end=+|+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qw(+  end=+)+ contains=@icgiperlInterpSQ,icgiperlParens
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qw{+  end=+}+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qw/+  end=+/+ contains=@icgiperlInterpSQ
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qr#+  end=+#[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qr|+  end=+|[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qr(+  end=+)[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qr{+  end=+}[imosx]*+ contains=@icgiperlInterpMatch
syn region icgiperlQQ		matchgroup=icgiperlStringStartEnd start=+\<qr/+  end=+/[imosx]*+ contains=@icgiperlInterpSlash

" Constructs such as print <<EOF [...] EOF, 'here' documents
"
if version >= 600
  " XXX Any statements after the identifier are in icgiperlString colour (i.e.
  " 'if $a' in 'print <<EOF if $a').
  if exists("icgiperl_fold")
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\z(\I\i*\)+    end=+^\z1$+ contains=@icgiperlInterpDQ fold
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*"\z(.\{-}\)"+ end=+^\z1$+ contains=@icgiperlInterpDQ fold
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*'\z(.\{-}\)'+ end=+^\z1$+ contains=@icgiperlInterpSQ fold
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*""+         end=+^$+    contains=@icgiperlInterpDQ,icgiperlNotEmptyLine fold
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*''+         end=+^$+    contains=@icgiperlInterpSQ,icgiperlNotEmptyLine fold
    syn region icgiperlAutoload	matchgroup=icgiperlStringStartEnd start=+<<['"]\z(END_\(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)['"]+ end=+^\z1$+ contains=ALL fold
  else
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\z(\I\i*\)+    end=+^\z1$+ contains=@icgiperlInterpDQ
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*"\z(.\{-}\)"+ end=+^\z1$+ contains=@icgiperlInterpDQ
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*'\z(.\{-}\)'+ end=+^\z1$+ contains=@icgiperlInterpSQ
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*""+         end=+^$+    contains=@icgiperlInterpDQ,icgiperlNotEmptyLine
    syn region icgiperlHereDoc	matchgroup=icgiperlStringStartEnd start=+<<\s*''+         end=+^$+    contains=@icgiperlInterpSQ,icgiperlNotEmptyLine
    syn region icgiperlAutoload	matchgroup=icgiperlStringStartEnd start=+<<\(['"]\|\)\z(END_\(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)\1+ end=+^\z1$+ contains=ALL
  endif
else
  syn match icgiperlUntilEOFStart	"<<EOF.*"lc=5 nextgroup=icgiperlUntilEOFDQ skipnl transparent
  syn match icgiperlUntilEOFStart	"<<\s*\"EOF\".*" nextgroup=icgiperlUntilEOFDQ skipnl transparent
  syn match icgiperlUntilEOFStart	"<<\s*'EOF'.*" nextgroup=icgiperlUntilEOFSQ skipnl transparent
  syn match icgiperlUntilEOFStart	"<<\s*\"\".*" nextgroup=icgiperlUntilEmptyDQ skipnl transparent
  syn match icgiperlUntilEOFStart	"<<\s*''.*" nextgroup=icgiperlUntilEmptySQ skipnl transparent
  syn region icgiperlUntilEOFDQ	matchgroup=icgiperlStringStartEnd start=++ end="^EOF$" contains=@icgiperlInterpDQ contained
  syn region icgiperlUntilEOFSQ	matchgroup=icgiperlStringStartEnd start=++ end="^EOF$" contains=@icgiperlInterpSQ contained
  syn region icgiperlUntilEmptySQ	matchgroup=icgiperlStringStartEnd start=++ end="^$" contains=@icgiperlInterpDQ,icgiperlNotEmptyLine contained
  syn region icgiperlUntilEmptyDQ	matchgroup=icgiperlStringStartEnd start=++ end="^$" contains=@icgiperlInterpSQ,icgiperlNotEmptyLine contained
  syn match icgiperlHereIdentifier	"<<EOF"
  syn region icgiperlAutoload	matchgroup=icgiperlStringStartEnd start=+<<\(['"]\|\)\(END_\(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)\1+ end=+^\(END_\(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)$+ contains=ALL
endif


" Class declarations
"
syn match  icgiperlPackageDecl	"^\s*\<package\s\+\S\+" contains=icgiperlStatementPackage
syn keyword icgiperlStatementPackage	package contained

" Functions
"       sub [name] [(prototype)] {
"
syn region icgiperlFunction		start="\s*\<sub\>" end="[;{]"he=e-1 contains=icgiperlStatementSub,icgiperlFunctionPrototype,icgiperlFunctionPRef,icgiperlFunctionName,icgiperlComment
syn keyword icgiperlStatementSub	sub contained

syn match  icgiperlFunctionPrototype	"([^)]*)" contained
if !exists("icgiperl_no_scope_in_variables")
   syn match  icgiperlFunctionPRef	"\h\w*::" contained
   syn match  icgiperlFunctionName	"\h\w*[^:]" contained
else
   syn match  icgiperlFunctionName	"\h[[:alnum:]_:]*" contained
endif


" All other # are comments, except ^#!
syn match  icgiperlComment		"#.*" contains=@Spell,icgiperlTodo
syn match  icgiperlSharpBang	"^#!.*"

" Formats
syn region icgiperlFormat		matchgroup=icgiperlStatementIOFunc start="^\s*\<format\s\+\k\+\s*=\s*$"rs=s+6 end="^\s*\.\s*$" contains=icgiperlFormatName,icgiperlFormatField,icgiperlVarPlain
syn match  icgiperlFormatName	"format\s\+\k\+\s*="lc=7,me=e-1 contained
syn match  icgiperlFormatField	"[@^][|<>~]\+\(\.\.\.\)\=" contained
syn match  icgiperlFormatField	"[@^]#[#.]*" contained
syn match  icgiperlFormatField	"@\*" contained
syn match  icgiperlFormatField	"@[^A-Za-z_|<>~#*]"me=e-1 contained
syn match  icgiperlFormatField	"@$" contained

" __END__ and __DATA__ clauses
if exists("icgiperl_fold")
  syntax region icgiperlDATA		start="^__\(DATA\|END\)__$" skip="." end="." contains=icgiperlPOD,@icgiperlDATA fold
else
  syntax region icgiperlDATA		start="^__\(DATA\|END\)__$" skip="." end="." contains=icgiperlPOD,@icgiperlDATA
endif


"
" Folding

if exists("icgiperl_fold")
  syn region icgiperlPackageFold start="^package \S\+;$" end="^1;$" end="\n\+package"me=s-1 transparent fold keepend
  syn region icgiperlSubFold     start="^\z(\s*\)\<sub\>.*[^};]$" end="^\z1}\s*$" end="^\z1}\s*\#.*$" transparent fold keepend
  syn region icgiperlBEGINENDFold start="^\z(\s*\)\<\(BEGIN\|END\|CHECK\|INIT\)\>.*[^};]$" end="^\z1}\s*$" transparent fold keepend

  if exists("icgiperl_fold_blocks")
    syn region icgiperlIfFold start="^\z(\s*\)\(if\|unless\|for\|while\|until\)\s*(.*)\(\s*{\)\=\s*$" start="^\z(\s*\)foreach\s*\(\(my\|our\)\=\s*\S\+\s*\)\=(.*)\(\s*{\)\=\s*$" start="\z(\s*\)else\s*{\s*$" end="^\z1}\s*;\=$" transparent fold keepend
    syn region icgiperlIfFold start="^\z(\s*\)do\(\s*{\)\=\s*$" end="^\z1}\s*while" end="^\z1}\s*;\=$" transparent fold keepend
  endif

  setlocal foldmethod=syntax
  syn sync fromstart
else
  " fromstart above seems to set minlines even if icgiperl_fold is not set.
  syn sync minlines=0
endif


if version >= 508 || !exists("did_icgiperl_syn_inits")
  if version < 508
    let did_icgiperl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlighting.
  HiLink icgiperlSharpBang		PreProc
  HiLink icgiperlControl		PreProc
  HiLink icgiperlInclude		Include
  HiLink icgiperlSpecial		Special
  HiLink icgiperlString		String
  HiLink icgiperlCharacter		Character
  HiLink icgiperlNumber		Number
  HiLink icgiperlFloat		Float
  HiLink icgiperlType		Type
  HiLink icgiperlIdentifier		Identifier
  HiLink icgiperlLabel		Label
  HiLink icgiperlStatement		Statement
  HiLink icgiperlConditional	Conditional
  HiLink icgiperlRepeat		Repeat
  HiLink icgiperlOperator		Operator
  HiLink icgiperlFunction		Function
  HiLink icgiperlFunctionPrototype	icgiperlFunction
  HiLink icgiperlComment		Comment
  HiLink icgiperlTodo		Todo
  if exists("icgiperl_string_as_statement")
    HiLink icgiperlStringStartEnd	icgiperlStatement
  else
    HiLink icgiperlStringStartEnd	icgiperlString
  endif
  HiLink icgiperlList		icgiperlStatement
  HiLink icgiperlMisc		icgiperlStatement
  HiLink icgiperlVarPlain		icgiperlIdentifier
  HiLink icgiperlFiledescRead	icgiperlIdentifier
  HiLink icgiperlFiledescStatement	icgiperlIdentifier
  HiLink icgiperlVarSimpleMember	icgiperlIdentifier
  HiLink icgiperlVarSimpleMemberName icgiperlString
  HiLink icgiperlVarNotInMatches	icgiperlIdentifier
  HiLink icgiperlVarSlash		icgiperlIdentifier
  HiLink icgiperlVarBang		icgiperlIdentifier
  HiLink icgiperlQQ			icgiperlString
  if version >= 600
    HiLink icgiperlHereDoc		icgiperlString
  else
    HiLink icgiperlHereIdentifier	icgiperlStringStartEnd
    HiLink icgiperlUntilEOFDQ	icgiperlString
    HiLink icgiperlUntilEOFSQ	icgiperlString
    HiLink icgiperlUntilEmptyDQ	icgiperlString
    HiLink icgiperlUntilEmptySQ	icgiperlString
    HiLink icgiperlUntilEOF		icgiperlString		
  endif
  HiLink icgiperlStringUnexpanded	icgiperlString
  HiLink icgiperlSubstitutionSQ	icgiperlString
  HiLink icgiperlSubstitutionDQ	icgiperlString
  HiLink icgiperlSubstitutionSlash	icgiperlString
  HiLink icgiperlSubstitutionHash	icgiperlString
  HiLink icgiperlSubstitutionBracket icgiperlString
  HiLink icgiperlSubstitutionCurly 	icgiperlString
  HiLink icgiperlSubstitutionPling	icgiperlString
  HiLink icgiperlTranslationSlash	icgiperlString
  HiLink icgiperlTranslationHash	icgiperlString
  HiLink icgiperlTranslationBracket	icgiperlString
  HiLink icgiperlTranslationCurly	icgiperlString
  HiLink icgiperlMatch		icgiperlString
  HiLink icgiperlMatchStartEnd	icgiperlStatement
  HiLink icgiperlFormatName		icgiperlIdentifier
  HiLink icgiperlFormatField	icgiperlString
  HiLink icgiperlPackageDecl	icgiperlType
  HiLink icgiperlStorageClass	icgiperlType
  HiLink icgiperlPackageRef		icgiperlType
  HiLink icgiperlStatementPackage	icgiperlStatement
  HiLink icgiperlStatementSub	icgiperlStatement
  HiLink icgiperlStatementStorage	icgiperlStatement
  HiLink icgiperlStatementControl	icgiperlStatement
  HiLink icgiperlStatementScalar	icgiperlStatement
  HiLink icgiperlStatementRegexp	icgiperlStatement
  HiLink icgiperlStatementNumeric	icgiperlStatement
  HiLink icgiperlStatementList	icgiperlStatement
  HiLink icgiperlStatementHash	icgiperlStatement
  HiLink icgiperlStatementIOfunc	icgiperlStatement
  HiLink icgiperlStatementFiledesc	icgiperlStatement
  HiLink icgiperlStatementVector	icgiperlStatement
  HiLink icgiperlStatementFiles	icgiperlStatement
  HiLink icgiperlStatementFlow	icgiperlStatement
  HiLink icgiperlStatementScope	icgiperlStatement
  HiLink icgiperlStatementInclude	icgiperlInclude
  HiLink icgiperlStatementProc	icgiperlStatement
  HiLink icgiperlStatementSocket	icgiperlStatement
  HiLink icgiperlStatementIPC	icgiperlStatement
  HiLink icgiperlStatementNetwork	icgiperlStatement
  HiLink icgiperlStatementPword	icgiperlStatement
  HiLink icgiperlStatementTime	icgiperlStatement
  HiLink icgiperlStatementMisc	icgiperlStatement
  HiLink icgiperlStatementNew	icgiperlStatement
  HiLink icgiperlFunctionName	icgiperlIdentifier
  HiLink icgiperlMethod		icgiperlIdentifier
  HiLink icgiperlFunctionPRef	icgiperlType
  HiLink icgiperlPOD		icgiperlComment
  HiLink icgiperlShellCommand	icgiperlString
  HiLink icgiperlSpecialAscii	icgiperlSpecial
  HiLink icgiperlSpecialDollar	icgiperlSpecial
  HiLink icgiperlSpecialString	icgiperlSpecial
  HiLink icgiperlSpecialStringU	icgiperlSpecial
  HiLink icgiperlSpecialMatch	icgiperlSpecial
  HiLink icgiperlSpecialBEOM	icgiperlSpecial
  HiLink icgiperlDATA		icgiperlComment
  
  HiLink icgiperlParens		Error
  
  " Possible errors
  HiLink icgiperlNotEmptyLine	Error
  HiLink icgiperlElseIfError	Error

  delcommand HiLink
endif

" Syncing to speed up processing
"
if !exists("icgiperl_no_sync_on_sub")
  syn sync match icgiperlSync	grouphere NONE "^\s*\<package\s"
  syn sync match icgiperlSync	grouphere icgiperlFunction "^\s*\<sub\s"
  syn sync match icgiperlSync	grouphere NONE "^}"
endif

if !exists("icgiperl_no_sync_on_global_var")
  syn sync match icgiperlSync	grouphere NONE "^$\I[[:alnum:]_:]+\s*=\s*{"
  syn sync match icgiperlSync	grouphere NONE "^[@%]\I[[:alnum:]_:]+\s*=\s*("
endif

if exists("icgiperl_sync_dist")
  execute "syn sync maxlines=" . icgiperl_sync_dist
else
  syn sync maxlines=100
endif

syn sync match icgiperlSyncPOD	grouphere icgiperlPOD "^=pod"
syn sync match icgiperlSyncPOD	grouphere icgiperlPOD "^=head"
syn sync match icgiperlSyncPOD	grouphere icgiperlPOD "^=item"
syn sync match icgiperlSyncPOD	grouphere NONE "^=cut"

let b:current_syntax = "icgiperl"

" vim: ts=8

" Vim syntax file
"  Language:	Man page
"  Maintainer:	Charles E. Campbell, Jr.
"  Last Change:	Jun 26, 2006
"  Version:    	3	ASTRO-ONLY
"
"  History:
"    2: * Now has conceal support
"       * complete substitute for distributed <man.vim>
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
if !has("conceal")
 " hide control characters, especially backspaces
 if version >= 600
  run! syntax/ctrlh.vim
 else
  so <sfile>:p:h/ctrlh.vim
 endif
endif

syn case ignore
" following four lines taken from Vim's <man.vim>:
syn match  manReference		"\f\+([1-9][a-z]\=)"
syn match  manTitle		"^\f\+([0-9]\+[a-z]\=).*"
syn match  manSectionHeading	"^[a-z][a-z ]*[a-z]$"
syn match  manOptionDesc	"^\s*[+-][a-z0-9]\S*"

syn match  manSectionHeading	"^\s\+[0-9]\+\.[0-9.]*\s\+[A-Z].*$"	contains=manSectionNumber
syn match  manSectionNumber	"^\s\+[0-9]\+\.[0-9]*"			contained
syn region manDQString		start='[^a-zA-Z"]"[^", )]'lc=1		end='"'		end='^$' contains=manSQString
syn region manSQString		start="[ \t]'[^', )]"lc=1		end="'"		end='^$'
syn region manSQString		start="^'[^', )]"lc=1			end="'"		end='^$'
syn region manBQString		start="[^a-zA-Z`]`[^`, )]"lc=1		end="[`']"	end='^$'
syn region manBQString		start="^`[^`, )]"			end="[`']"	end='^$'
syn region manBQSQString	start="``[^),']"			end="''"	end='^$'
syn match  manBulletZone	"^\s\+o\s"				transparent contains=manBullet
syn case match

syn keyword manBullet		o					contained
syn match   manBullet		"\[+*]"					contained
syn match   manSubSectionStart	"^\*"					skipwhite nextgroup=manSubSection
syn match   manSubSection	".*$"					contained
syn match   manOptionWord	"\s[+-]\a\+\>"

if has("conceal")
 setlocal conc=3
 syn match manSubTitle		/\(.\b.\)\+/	contains=manSubTitleHide
 syn match manUnderline		/\(_\b.\)\+/	contains=manSubTitleHide
 syn match manSubTitleHide	/.\b/		conceal contained
endif

" my RH8 linux's man page puts some pretty oddball characters into its
" manpages...
silent! %s/’/'/ge
silent! %s/−/-/ge
silent! %s/‐$/-/e
silent! %s/‘/`/ge
silent! %s/‐/-/ge
norm! 1G

set ts=8

if version >= 508 || !exists("did_man_syn_inits")
  if version < 508
    let did_man_syn_inits = 1
    com! -nargs=+ HiLink hi link <args>
  else
    com! -nargs=+ HiLink hi def link <args>
  endif

  HiLink manTitle		Title
"  HiLink manSubTitle		Statement
  HiLink manUnderline		Type
  HiLink manSectionHeading	Statement
  HiLink manOptionDesc		Constant

  HiLink manReference		PreProc
  HiLink manSectionNumber	Number
  HiLink manDQString		String
  HiLink manSQString		String
  HiLink manBQString		String
  HiLink manBQSQString		String
  HiLink manBullet		Special
  if has("win32") || has("win95") || has("win64") || has("win16")
   if &shell == "bash"
    hi manSubSectionStart	term=NONE      cterm=NONE      gui=NONE      ctermfg=black ctermbg=black guifg=navyblue guibg=navyblue
    hi manSubSection		term=underline cterm=underline gui=underline ctermfg=green guifg=green
    hi manSubTitle		term=NONE      cterm=NONE      gui=NONE      ctermfg=cyan ctermbg=blue guifg=cyan guibg=blue
   else
    hi manSubSectionStart	term=NONE      cterm=NONE      gui=NONE      ctermfg=black ctermbg=black guifg=black guibg=black
    hi manSubSection		term=underline cterm=underline gui=underline ctermfg=green guifg=green
    hi manSubTitle		term=NONE      cterm=NONE      gui=NONE      ctermfg=cyan ctermbg=blue guifg=cyan guibg=blue
   endif
  else
   hi manSubSectionStart	term=NONE      cterm=NONE      gui=NONE      ctermfg=black ctermbg=black guifg=navyblue guibg=navyblue
   hi manSubSection		term=underline cterm=underline gui=underline ctermfg=green guifg=green
   hi manSubTitle		term=NONE      cterm=NONE      gui=NONE      ctermfg=cyan ctermbg=blue guifg=cyan guibg=blue
  endif

  delcommand HiLink
endif

let b:current_syntax = "man"

" vim:ts=8

" Vim syntax file
" Language:	Just plain text file with custom highlighting
" Maintainer:	Alex Efros <powerman@powerman.asdfgroup.com>
" Last Change:	2004 Feb 14

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'note_with_script'
endif

if version < 600
  syn include @NOTEperl <sfile>:p:h/perl.vim
  syn include @NOTEsh   <sfile>:p:h/sh.vim
else
  syn include @NOTEperl syntax/perl.vim
  unlet b:current_syntax
  syn include @NOTEsh	syntax/sh.vim
  unlet b:current_syntax
endif

" ������������
syn match   noteTitle		"^[*=-]\{3,}.*" contains=@Spell
" url � ����� ������/��������� (� ������ ���������� bash-������ ����.�������)
syn match   noteUrl		"\(https\?\|ftp\)://\S\+"
syn match   notePathSpec	"[?*]" contained
syn match   notePathInBraceSpec	"," contained
syn region  notePathInBrace	matchgroup=notePathBrace start=+\[+ end=+\]+ transparent contained contains=notePathInBrace,notePathInBraceSpec,notePathSpec
syn region  notePathInBrace	matchgroup=notePathBrace start=+{+  end=+}+  transparent contained contains=notePathInBrace,notePathInBraceSpec,notePathSpec
syn match   notePath		"\(^\|[^/A-Za-z0-9_.-]\)\@<=\(\.\{0,2}\|\~\)/[/A-Za-z0-9_.\[\]{}*?,-]*" contains=notePathInBrace,notePathSpec
" ������ � ��������� ��������
syn region  noteExecute		start=+\(^\|\W\)\@<=`+ end=+`+
syn region  noteStrDoubleQuoted	start=+\(^\|\W\)\@<="+ end=+"+ contains=@Spell
syn region  noteStrSingleQuoted	start=+\(^\|\W\)\@<='+ end=+'+ contains=@Spell
" ����� ������� � ����������
syn match   noteFunction	"\<[A-Za-z0-9_]\+()"
syn region  noteVariableBrace	start=+{+ end=+}+ transparent contained contains=noteVariableBrace
syn match   noteVariable	"$[A-Za-z0-9_:.{}\[\]]\+" contains=noteVariableBrace
" ������� ��������� ������ � ������ � ������������
syn match   noteList		"^\s*\(\*\|-\|+\|\d\+)\)\(\s\|$\)"
syn match   noteCommentList	"\(^\s*#\)\@<=\s*\(\*\|-\|+\|\d\+)\)\(\s\|$\)"
" ����-����� :)
syn keyword noteTodo		TODO ToDo NOTE INFO FIXME
syn keyword noteWarn		WARNING WARN Warning ERROR ERR Error DIE BUG
" �����������
syn match   noteComment		"#.*" contains=@Spell,noteTodo,noteWarn,noteCommentList
" ���������� ����� � ������ ����������� (perl, sh, etc...)
syn region  notePerlBlock	keepend matchgroup=Delimiter start=+<PERL>+ end=+</PERL>+ transparent contains=@NOTEperl
syn region  noteShBlock		keepend matchgroup=Delimiter start=+<SH>+ end=+</SH>+ transparent contains=@NOTEsh

syn match   noteTOP		".*" contains=@Spell,noteTitle,noteUrl,notePath,noteExecute,noteStrDoubleQuoted,noteStrSingleQuoted,noteFunction,noteVariable,noteList,noteComment,noteTodo,noteWarn,notePerlBlock,noteShBlock

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_diff_syntax_inits")
  if version < 508
    let did_diff_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

"  hi	    noteTitle		cterm=none ctermfg=0 ctermbg=6
  HiLink    noteUrl		NonText
  HiLink    notePathSpec	Directory
  HiLink    notePathInBraceSpec	notePathSpec
  HiLink    notePathBrace	notePathSpec
  HiLink    notePath		NonText
  HiLink    noteExecute		Folded
  HiLink    noteStrSingleQuoted Statement
  HiLink    noteStrDoubleQuoted String
  HiLink    noteFunction	Special
  HiLink    noteVariable	Identifier
  HiLink    noteList		WarningMsg
"  hi	    noteCommentList	cterm=bold ctermfg=1 ctermbg=0
  HiLink    noteTodo		Todo
  HiLink    noteWarn		Error
  HiLink    noteComment		Comment
"  hi	    Delimiter		cterm=bold ctermfg=0

  delcommand HiLink
endif

let b:current_syntax = "note"

" vim: ts=8 sw=2

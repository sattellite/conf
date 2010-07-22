" Summary:							Plugin:	    
"   * Разные настройки							    
"   * Помощь: man/perldoc			<F1>		manpageview 
"   * Сохранение				<F2>			    
"   * Исполняемый файл				<F3>
"   * Вкл/Выкл вставку as-is			<F4>			    
"   * Перекодирование между KOI<->WIN<->DOS	<F6>			    
"   * Выход (если все файлы записаны)		<F10>			    
"   * Проверка на ошибки perl-скрипта при записи<F11>, <F12>		    
"   * Переключение между файлами (NORMAL)	<Tab>, <S-Tab>		    
"   * Выделение текста				<Shift>+Arrows		    
"						<Shift>+<Home>,<End>	    
"   * Запоминание выделенного текста		<Ctrl>+<Insert>		    
"   * Прокрутка текста без смещения курсора	<Ctrl>+Arrows		    
"   * Переход по tag-ссылкам			<Alt>+Arrows		    
"   * За|Рас-комментирование			#, <Alt>+#,     commentify  
"						<Ctrl>+C		    
"   * Полноэкранный режим						    
"   * Проверка правописания 						    
"   * Transparent editing of gpg encrypted files			    
"   * Ускоренное открытие больших файлов				    
"   * Подсветка синтаксиса						    
"   * Разная мелочь для удобства					    


""" Разные настройки
""" (все переменные комментировать лень, так что - :help)
set number
set fileencodings=utf-8
set nobackup
set textwidth=100
set shiftwidth=4
set tabstop=4
"set softtabstop=4
set nohlsearch
set incsearch
set nowrap
set sidescroll=1
set sidescrolloff=1
set wildmenu
set showcmd
set comments-=:%
set comments+=fb:*,fb:+,fb:.
set mouse=a
set completeopt-=menu
" set spellfile=~/.vim/spell/en.ascii.add,~/.vim/spell/ru.koi8-r.add
" Есть два варианта indent-а: 'filetype' и 'smart', включать можно один из них
" filetype indent on
set smartindent
inoremap # X#
" Во избежание потенциальных проблем с безопасностью
set modelines=0

syntax sync fromstart

""" Поддержка командного режима при русской раскладке (аналог langmap для UTF-8)
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

""" Просмотр документации man/info/perldoc.
""" Plugin: manpageview + мой патч
""" <F1> вызывает man для текущего слова (в perl-скриптах вызывает perldoc)
""" :Man manpage
""" :Man infopage.i
""" :Man perlpage.pl
""" :help manpageview
""" Окна с документацией можно быстро закрыть: q .
""" Для использования из командной строки добавить в ~/.bashrc:
"""	function man()  { vim -c "Man $1 $2"; }
"""	function info() { vim -c "Man $1.i"; }
let g:manpageview_pgm="LANG= man"   " I hate russian man pages!!! :-E~
imap <F1> <Esc>:exe "Man ".expand("<cword>")<CR>
nmap <F1>      :exe "Man ".expand("<cword>")<CR>
autocmd FileType vim  :nmap <buffer> <F1>      :exe "help ".expand("<cword>")<CR>
autocmd FileType vim  :imap <buffer> <F1> <Esc>:exe "help ".expand("<cword>")<CR>
autocmd FileType perl :nmap <buffer> <F1>      :exe "Man ".expand("<cword>").".pl"<CR>
autocmd FileType perl :imap <buffer> <F1> <Esc>:exe "Man ".expand("<cword>").".pl"<CR>
autocmd FileType perl :setlocal iskeyword=@,48-57,_,192-255,:
autocmd FileType man  :nmap <buffer> q :call QuitHelp()<CR>
autocmd FileType info :nmap <buffer> q :call QuitHelp()<CR>
autocmd FileType help :nmap <buffer> q :call QuitHelp()<CR>
function QuitHelp()
    bd
    if bufname("%")==""
	q
    endif
endfunction


""" Сохранение: <F2>
nmap <F2> :w<CR>
vmap <F2> <ESC>:w<CR>
imap <F2> <C-O>:w<CR>
cmap <F2> <Esc><Esc>:w<CR>


""" Исполняемый файл: <F3>
nmap <F3> :silent !chmod a+x %<CR>
vmap <F3> <ESC>:silent !chmod a+x %<CR>
imap <F3> <C-O>:silent !chmod a+x %<CR>
cmap <F3> <Esc><Esc>:silent !chmod a+x %<CR>


""" Вкл/Выкл вставку as-is: <F4>
""" в NORMAL: i и <Insert> всегда входят в INSERT с nopaste
""" в NORMAL: <F4> входит в INSERT с paste
""" в INSERT: <F4> переключает paste/nopaste
nnoremap <F4>	    :set paste<CR>i
nnoremap i	    :set nopaste<CR>i
nnoremap <Insert>   :set nopaste<CR><Insert>
imap <F4> <C-O>:set paste<CR>
set pastetoggle=<xF4>


""" Перекодирование файла между русскими кодировками: <F6>
""" (кодировки выбираются через меню)
set wcm=<Tab>
menu Encoding.Koi->UTF	:silent %!iconv -c -f koi8-r -t utf-8 <CR>
menu Encoding.UTF->Koi	:silent %!iconv -c -f utf-8  -t koi8-r<CR>
menu Encoding.Win->UTF	:silent %!iconv -c -f cp1251 -t utf-8 <CR>
menu Encoding.UTF->Win	:silent %!iconv -c -f utf-8  -t cp1251<CR>
menu Encoding.Dos->UTF  :silent %!iconv -c -f cp866  -t utf-8 <CR>
menu Encoding.UTF->Dos	:silent %!iconv -c -f utf-8  -t cp866 <CR>
map <F6> :emenu Encoding.<TAB>


""" Выход (если файл записан) <F10>
nmap <F10>   :qa<CR>
vmap <F10>   <Esc>:qa<CR>
imap <F10>   <Esc>:qa<CR>
cmap <F10>   <Esc><Esc>:qa<CR>


""" Проверка на ошибки perl-скрипта при записи на диск
""" Переход к следующей/предыдущей ошибке <F12>/<F11>
set makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $*
autocmd FileType limbo setlocal makeprg=[[\ %\ ==\ *.b\ ]]\ &&\ limbo\ -g\ -w\ %
set errorformat=%f:%l:%m
"nmap <F11>	:cprevious<CR>
"nmap <F12>	:cnext<CR>
"imap <F11> <C-O>:cprevious<CR>
"imap <F12> <C-O>:cnext<CR>
nmap <F11>	:call QFprevorclose()<CR>
nmap <F12>	:call QFnextorclose()<CR>
imap <F11> <C-O>:call QFprevorclose()<CR>
imap <F12> <C-O>:call QFnextorclose()<CR>
autocmd BufWritePost * call Make()
function Make()
    if &ft == "perl" || &ft == "limbo"
	silent! make
	cwindow 3
	" при открытии/обновлении quickfix window глючит подсветка
	if bufwinnr("$") > 1
	    redraw!
	endif
    endif
endfunction
function QFprevorclose()
    try
        cprevious
    catch
	cclose
    endtry
endfunction
function QFnextorclose()
    try
        cnext
    catch
	cclose
    endtry
endfunction


""" Переключение между открытыми файлами: <Tab>, <Shift>+<Tab>
"nmap <Tab>   :cclose<CR>:tabn<CR>
"nmap <S-Tab> :cclose<CR>:tabp<CR>
"set hidden
nmap <Tab>   :tabn<CR>
nmap <S-Tab> :tabp<CR>
set hidden

""" Запоминание выделенного текста (в буфер VIM и в X Clipboad): Ctrl-Insert
""" Вырезание   выделенного текста (в буфер VIM и в X Clipboad): Shift-Del
vmap <silent> <Esc>[2;5~ y:call system("echo -n \"".escape(getreg(""),"\\\"$`")."\" \| xclip")<CR>gvv
vmap <silent> <Esc>[3;2~ d:call system("echo -n \"".escape(getreg(""),"\\\"$`")."\" \| xclip")<CR>


""" Переход по tag-ссылкам: <Alt>+Arrows
autocmd FileType man  let b:tag_regex="\\S\\+(.)"
autocmd FileType help let b:tag_regex="|\\S\\+|\\|'\\S\\+'\\|{\\S\\+}"
autocmd FileType perl let b:tag_regex="\\<\\w\\+\\(::\\|(\\)"
nmap <Esc>[1;3A :call search(b:tag_regex,"bW")<CR>
nmap <Esc>[1;3B :call search(b:tag_regex,"W")<CR>
nmap <Esc>[1;3C	<C-]>
nmap <Esc>[1;3D <C-T>


""" Проверка правописания
" autocmd FileType mail,text,note,asciidoc,html,vim,perl,limbo,changelog setlocal spell spelllang=en,ru


" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
" Folding permanence added by me.
augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Save&Restore folding
    autocmd BufReadPost,FileReadPost	*.gpg loadview
    autocmd BufWritePre,FileWritePre	*.gpg mkview

    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost  *.gpg u
    
    autocmd BufWritePost,FileWritePost	*.gpg loadview
augroup END


""" Ускоренное открытие больших файлов
""" (можно ограничиться простым syntax off, но так вроде правильнее)
let g:LargeFile = "3000000"
autocmd BufReadPre * call FasterLargeFiles()
function FasterLargeFiles()
    let f=expand("<afile>")
    if exists("g:LargeFile") && getfsize(f) > g:LargeFile
	set ei=FileType
	setlocal noswf bh=unload bt=nowrite ro
	let f=escape(substitute(f,'\','/','g'),' ')
	augroup LargeFile
	au!
	exe "au LargeFile BufEnter ". f ." set ul=-1 ei=FileType"
	exe "au LargeFile BufLeave ". f ." set ul=1000 ei="
	exe "au LargeFile BufUnload ". f ." au! LargeFile * ". f
	augroup END
    endif
endfunction


""" Подсветка синтаксиса
colorscheme desert256
"colorscheme inkpot
"colorscheme jellybeans


""" Нумерация строк 
set number

""" Подсветка синтаксиса: perl
let perl_include_pod=1
" кавычки подсвечивать не как строку, а как if, while, ...
let perl_string_as_statement=1		
" подсвечивать имя пакета
let perl_want_scope_in_variables=1	
" @{ $qwe{asd}[123] }
let perl_extended_vars=1		

""" Подсветка синтаксиса: iCGI
" let icgiperl_want_scope_in_variables=1
let icgiperl_extended_vars=1
let icgiperl_string_as_statement=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                                                                        "
"""                  Разная мелочь для удобства                            "
"""                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""" Выбор типа для 'странных' файлов
autocmd BufNewFile,BufRead *.note		set ft=note
autocmd BufNewFile,BufRead *TODO*		set ft=note
autocmd BufNewFile,BufRead *TechSpec*		set ft=note
autocmd BufNewFile,BufRead *BUG*	        set ft=note
autocmd BufNewFile,BufRead *vim*/doc/*.txt	set ft=help
autocmd BufNewFile,BufRead *.opera/cache*	set ft=html
autocmd BufNewFile,BufRead *.htmlt		set ft=html
autocmd BufNewFile,BufRead *.html-*		set ft=html
autocmd BufNewFile,BufRead *.cgi-*		set ft=perl
autocmd BufNewFile,BufRead *.pl-*		set ft=perl
autocmd BufNewFile,BufRead *.pm-*		set ft=perl
autocmd BufNewFile,BufRead *.t			set ft=perl
autocmd BufNewFile,BufRead *.b			set ft=limbo
autocmd BufNewFile,BufRead *.m			set ft=limbo
autocmd BufNewFile,BufRead *.txt		set ft=asciidoc


""" Programming
autocmd FileType perl,sh			setlocal formatoptions-=t
autocmd FileType limbo				setlocal tabstop=9 softtabstop=9 shiftwidth=9


""" Editing asciidoc
nnoremap Q gq}
autocmd BufRead,BufNewFile *.txt		setlocal autoindent expandtab

""" Tags
" Поиск tags везде где дотянусь в пределах типового веб-проекта
set tags+=./.lib/.tmp/tags,./../.lib/.tmp/tags,./../../.lib/.tmp/tags,./../../../.lib/.tmp/tags,./../../../../.lib/.tmp/tags


""" Make
" Использование вспомогательных скриптов при проверке синтаксиса некоторых
" perl-скриптов для подгрузки всех нужных (для проверяемого) модулей и
" файлов, плюс дополнительная фильтрация неактуальных warning-ов
"autocmd BufRead */t/*		  setlocal makeprg=check_tests\ %\ $*
"autocmd BufRead /var/www/*/html/* if &ft == "perl"|setlocal makeprg=check_project\ %\ $*|endif
"autocmd BufRead */*-*/lib/*.pm	  setlocal makeprg=check_module\ %\ $*

""" Патчи
autocmd BufRead *.patch	    exe "FoldMatching ^diff -1" | normal 1G


""" Почта
""" (при вводе письма перейти сразу на вторую пустую строку и в режим вставки)
autocmd BufRead	      /tmp/mutt*	/^$/|/^$/|set fo=tcrq|startinsert


""" Abbr
" Вставлять дату/время.
"iabbr DATE <c-r>=strftime("%d/%m/%y %H:%M:%S")<CR>
iabbr DATE <c-r>=strftime("%d/%m/%y")<CR>
iabbr DATEen <Esc>:let lc_time_=v:lc_time<CR>:language time C<CR>i<Right><c-r>=strftime("%a %b %d %X %Z %Y")<CR><Esc>:execute "language time " . lc_time_<CR>:unlet lc_time_<CR>a
" Кракозябры для iCGI
func Eatchar(pat)
    let c = nr2char(getchar())
    return (c =~ a:pat) ? '' : c
endfunc
autocmd BufNewFile,BufRead *.html               call HTML_Abbr()
fun! HTML_Abbr()
"    iabbr <buffer> if	 if () { --><!--& } --><Up><Left><C-R>=Eatchar('\s')<CR>
"    iabbr <buffer> for	 for () { --><!--& } --><Up><C-R>=Eatchar('\s')<CR>
    iabbr <buffer> @~    @~~@<Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <buffer> ^~    ^~~^<Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <buffer> #~    #~~#<Left><Left><C-R>=Eatchar('\s')<CR>
    iabbr <buffer> <a    <a href=""></a><Left><Left><Left><Left><Left><Left><C-R>=Eatchar('\s')<CR>
endfun


""" Если нажат <Enter> - наверное это не зря? Наверное что-то добавить хотца...
nmap <Enter> A<Enter>


""" Фильтр для удаления из html всех тегов кроме тегов форм:  :ShowForm
function! s:ShowForm()
    %!perl -p0e 'use Regexp::Common "RealHTML"; $_=join"\n",map{s/\s*$//;$_}/<\/?(?:form|input|select|option|textarea|button)${RE{">"}}[^<]*/ig'
endfunction
command! ShowForm :call <SID>ShowForm()


""" Определение текущей группы подсветки: \hi и \hlt
map \hi  :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


""" Шаблоны для новых файлов
"au BufNewFile 	*.pl	0r~/.skel.pl | exe "normal G" | startinsert


""" Копирование между разными VIM-процессами
""" (не нужно - <Ctrl>+<Insert> и <Shift>+<Insert> гораздо удобнее!)
"nmap \x   :r  ${HOME}/.vimxfer<CR>
"vmap \x   :w! ${HOME}/.vimxfer<CR>


""" Автоматически сворачивать perl-процедуры (подглюкивает на моих клозурах)
" let perl_fold=1


""" Поиск в текущем окне по perl-овскому регулярному выражению.
""" Выражение вводится в виде /regexhere/si или !regexhere! и т.п.
""" В выражении можно использовать $t как сокращение для [^>]*>\s*
""" Для того, чтобы помимо установки курсора на начало совпадения текст
""" совпадения был выделен цветом нужно раскомментировать VIM::DoCommand()
""" и настроить цвет в строке 'hi perlre ...'
""" Для поиска от курсора нажать <F7>. Для повторного поиска <F7><Enter>.
""" Передвижение курсора между началом совпадения perl-овского регулярного
""" выражения и концом совпадения (Shift+F7).
"nmap <F7> :call PerlSearch()<cr>
"nmap <S-F7> :call PerlSearchSE()<cr>
"hi perlre ctermbg=white ctermfg=blue
"function! PerlSearch()
"perl <<EOF
"    sub getxy {
"	(my $s=substr($_[0],0,$_[1]))=~/.*\n/s;
"	(1+($s=~tr/\n//), $_[1]-$+[0])
"    }
"    sub re_start_end {
"	my $buf=join("\n",$curbuf->Get(1..$curbuf->Count()));
"	my($y,$x)=$curwin->Cursor();
"	$y--; $x++;
"	$buf=~/(?:.*\n){$y}.{$x}/g;
"	return unless $buf=~/($_[0])/g;
"	my ($s,$e)=($-[0],$+[0]-1);
"	$e-- if substr($buf,$e,1) eq "\n";
"	getxy($buf,$s), getxy($buf,$e)
"    }
"    $PerlSearch::regex = VIM::Eval('input("=~ ","'."\Q$PerlSearch::regex\E".'")');
"  my $t = qr/[^>]*>\s*/;
"    return VIM::Msg("No matches found","Error")
"	unless my @c = re_start_end(eval 'qr'.$PerlSearch::regex);
"    #VIM::DoCommand('match perlre /\%'.$c[0].'l\%'.($c[1]+1).'c\_.*'.
"    #				 '\%'.$c[2].'l\%'.($c[3]+2).'c/');
"    @PerlSearch::c = @c;
"    $curwin->Cursor($c[0],$c[1]);
"EOF
"endfunction
"function! PerlSearchSE()
"perl <<EOF
"    @PerlSearch::c = @PerlSearch::c[2,3,0,1];
"    $curwin->Cursor($PerlSearch::c[0],$PerlSearch::c[1]);
"EOF
"endfunction


""" Пример использования perl:
" First, a customizable word count
" :perl $count = 0
" :perldo $count += split /[;_<> ]/, $_ 
" :perl VIM::Msg($count)
" Then, a special sorting routine, getting text from the editor's current
" buffer and writing back to it:
" :perl @lines = sort {$a <=> $b} $curbuf->Get(1 .. 15)
" :perl $curbuf->Set(1, @lines)
" Or, in short,
" :perl $curbuf->Set(1, sort {$a <=> $b} $curbuf->Get(1 .. 15))


""" Отладка событий
"autocmd BufNewFile		* echo "BufNewFile"." at ".expand("<afile>")
"autocmd BufReadPre		* echo "BufReadPre"." at ".expand("<afile>")
"autocmd BufRead			* echo "BufRead"." at ".expand("<afile>")
"autocmd BufReadPost		* echo "BufReadPost"." at ".expand("<afile>")
""autocmd BufReadCmd		* echo "BufReadCmd"." at ".expand("<afile>")
"autocmd BufFilePre		* echo "BufFilePre"." at ".expand("<afile>")
"autocmd BufFilePost		* echo "BufFilePost"." at ".expand("<afile>")
"autocmd FileReadPre		* echo "FileReadPre"." at ".expand("<afile>")
"autocmd FileReadPost		* echo "FileReadPost"." at ".expand("<afile>")
""autocmd FileReadCmd		* echo "FileReadCmd"." at ".expand("<afile>")
"autocmd FilterReadPre		* echo "FilterReadPre"." at ".expand("<afile>")
"autocmd FilterReadPost		* echo "FilterReadPost"." at ".expand("<afile>")
"autocmd FileType		* echo "FileType"." at ".expand("<afile>")
"autocmd Syntax			* echo "Syntax"." at ".expand("<afile>")
"autocmd StdinReadPre		* echo "StdinReadPre"." at ".expand("<afile>")
"autocmd StdinReadPost		* echo "StdinReadPost"." at ".expand("<afile>")
"autocmd BufWrite		* echo "BufWrite"." at ".expand("<afile>")
"autocmd BufWritePre		* echo "BufWritePre"." at ".expand("<afile>")
"autocmd BufWritePost		* echo "BufWritePost"." at ".expand("<afile>")
""autocmd BufWriteCmd		* echo "BufWriteCmd"." at ".expand("<afile>")
"autocmd FileWritePre		* echo "FileWritePre"." at ".expand("<afile>")
"autocmd FileWritePost		* echo "FileWritePost"." at ".expand("<afile>")
""autocmd FileWriteCmd		* echo "FileWriteCmd"." at ".expand("<afile>")
"autocmd FileAppendPre		* echo "FileAppendPre"." at ".expand("<afile>")
"autocmd FileAppendPost		* echo "FileAppendPost"." at ".expand("<afile>")
""autocmd FileAppendCmd		* echo "FileAppendCmd"." at ".expand("<afile>")
"autocmd FilterWritePre		* echo "FilterWritePre"." at ".expand("<afile>")
"autocmd FilterWritePost		* echo "FilterWritePost"." at ".expand("<afile>")
"autocmd FileChangedShell	* echo "FileChangedShell"." at ".expand("<afile>")
"autocmd FileChangedRO		* echo "FileChangedRO"." at ".expand("<afile>")
"autocmd FocusGained		* echo "FocusGained"." at ".expand("<afile>")
"autocmd FocusLost		* echo "FocusLost"." at ".expand("<afile>")
""autocmd FuncUndefined		* echo "FuncUndefined"." at ".expand("<afile>")
""autocmd CursorHold		* echo "CursorHold"." at ".expand("<afile>")
"autocmd BufEnter		* echo "BufEnter"." at ".expand("<afile>")
"autocmd BufLeave		* echo "BufLeave"." at ".expand("<afile>")
"autocmd BufWinEnter		* echo "BufWinEnter"." at ".expand("<afile>")
"autocmd BufWinLeave		* echo "BufWinLeave"." at ".expand("<afile>")
"autocmd BufUnload		* echo "BufUnload"." at ".expand("<afile>")
"autocmd BufHidden		* echo "BufHidden"." at ".expand("<afile>")
"autocmd BufNew			* echo "BufNew"." at ".expand("<afile>")
"autocmd BufAdd			* echo "BufAdd"." at ".expand("<afile>")
"autocmd BufCreate		* echo "BufCreate"." at ".expand("<afile>")
"autocmd BufDelete		* echo "BufDelete"." at ".expand("<afile>")
"autocmd BufWipeout		* echo "BufWipeout"." at ".expand("<afile>")
"autocmd WinEnter		* echo "WinEnter"." at ".expand("<afile>")
"autocmd WinLeave		* echo "WinLeave"." at ".expand("<afile>")
"autocmd CmdwinEnter		* echo "CmdwinEnter"." at ".expand("<afile>")
"autocmd CmdwinLeave		* echo "CmdwinLeave"." at ".expand("<afile>")
""autocmd GUIEnter		* echo "GUIEnter"." at ".expand("<afile>")
""autocmd VimEnter		* echo "VimEnter"." at ".expand("<afile>")
""autocmd VimLeavePre		* echo "VimLeavePre"." at ".expand("<afile>")
""autocmd VimLeave		* echo "VimLeave"." at ".expand("<afile>")
""autocmd EncodingChanged	* echo "EncodingChanged"." at ".expand("<afile>")
""autocmd FileEncoding		* echo "FileEncoding"." at ".expand("<afile>")
""autocmd RemoteReply		* echo "RemoteReply"." at ".expand("<afile>")
""autocmd TermChanged		* echo "TermChanged"." at ".expand("<afile>")
""autocmd TermResponse		* echo "TermResponse"." at ".expand("<afile>")
""autocmd User			* echo "User"." at ".expand("<afile>")

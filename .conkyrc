# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
alias out='wgetpaste -s dpaste -n sattellite -XC'
alias shot="scrot -d 3 '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f ~/Изображения/shots/'"
alias tor="echo 'scrot -s -e '\mv $\f ~/Прочее/torrents/'\'"

complete -F _man $filenames man2pdf

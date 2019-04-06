#!/bin/bash
#set -Ceu
#-----------------------------------------------------------------------------
# Shellの特殊ファイルとその操作（リダイレクト、パイプ）
# 作成日時: 2019-04-06T11:02:31+0900
# http://ytyaru.hatenablog.com/entry/2020/06/08/000000
#-----------------------------------------------------------------------------
Run() {
	Redirect
	HereDocument
	Pipe
	Finalize
}
Redirect() {
	RedirectStream
	RedirectFile
	RedirectTerminal
	RedirectDevNull
	RedirectFileDescripter
}
RedirectStream() {
	echo 'A'
	echo 'A' 1>&2
	echo 'A' >&2
	{ echo 'Out'; echo 'Err' >&2; } 1>out.txt 2>err.txt
	cat out.txt
	cat err.txt
	{ echo 'Out'; echo 'Err' >&2; }

	echo 'A' >2
	rm -Rf 2

}
RedirectFile() {
	echo 'A' > a.txt
	cat < a.txt
}
RedirectTerminal() {
	local -r T0=$(tty)
	echo 'AAA' > $T0
}
RedirectDevNull() {
	echo A >/dev/null
	{ echo Out; echo Err >&2; } 2>/dev/null
}
RedirectFileDescripter() {
	exec 3< <(echo A); cat <&3; exec 3>&-;
	exec {fd}< <(echo A); cat <&${fd}; exec {fd}>&-;
}
Pipe() {
	echo -e 'A\nB\nC' | grep 'B'
	echo -e 'B\nA\nC\nA' | sort | uniq
	PipeRandom
}
PipeRandom() {
	#cat /dev/urandom
	cat /dev/urandom | head -c 100
	cat /dev/urandom | tr -dc "[:alnum:]" | head -c 100
	cat /dev/urandom | tr -dc "[:alnum:]" | fold -w 16 | head -c 100
	cat /dev/urandom | tr -dc "[:alnum:]" | fold -w 16 | head -n 5
}
Finalize() { for file in out.txt  err.txt  a.txt; do rm -Rf $file; done; }
Run

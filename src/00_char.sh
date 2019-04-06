#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# bashのメタ文字・予約語・コメント・エスケープシーケンス
# 作成日時: 2019-04-06T09:20:37+0900
# http://ytyaru.hatenablog.com/entry/2020/06/09/000000
#-----------------------------------------------------------------------------
Run() {
	EscapeSequence
	Example
	Finalize
}
EscapeSequence() {
	echo -e 'A\tB\n1\t2'
	echo "I'm Andy."
	echo 'I'\''m Andy.'
	URL='https://example.com'
	echo "<a href=\"${URL}\"></a>"
	echo '<a href="'"${URL}"'"></a>'
}
Example() {
	echo 'A'
	echo 'B'

	echo 'A'; echo 'B';
	echo 'A';	echo 'B';
	echo 'A' && echo 'B';

	echo 'A' & echo 'B';
	{ echo 'A'; sleep 2; } & echo 'B';

	(echo 'A'; echo 'B')
	{ echo 'A'; echo 'B'; }
	(echo 'A' && echo 'B')
	{ echo 'A' && echo 'B'; }

	[ 1 -eq 1 ] && echo 'TRUE' || echo 'FALSE';
	[ ! 1 -eq 1 ] && echo 'TRUE' || echo 'FALSE';
	[ 1 -eq 1 -a 1 -eq 2 ] && echo 'TRUE' || echo 'FALSE';
	[ 1 -eq 1 -o 1 -eq 2 ] && echo 'TRUE' || echo 'FALSE';
	[ 'A' = 'A' ] && echo 'TRUE' || echo 'FALSE';

	[[ A = A ]] && echo 'TRUE' || echo 'FALSE';
	[[ A = A && B = C ]] && echo 'TRUE' || echo 'FALSE';
	[[ A = A || B = C ]] && echo 'TRUE' || echo 'FALSE';

	_NAME1='N'; echo "$_NAME1";
	NAME='N'; echo '$NAME'; echo "$NAME";

	echo -e 'A\nB' | grep 'B'
	{ echo Out; echo Err >&2; } |& cat

	#echo A > a.txt #存在するファイルを上書きできません
	echo A >| a.txt
	cat < a.txt

	NAME=A; case $NAME in A) echo 'NAME is A.';; B) echo 'NAME is B.';; *) echo 'Another...';; esac

	NAME=A
	case $NAME in
	A) echo 'NAME is A.';;
	B) echo 'NAME is B.';;
	*) echo 'Another...';;
	esac

	while [ 1 -eq 1 ]; do echo 'while!'; break; done;
	until [ ! 1 -eq 1 ]; do echo 'while!'; break; done;

	if [ 1 -eq 1 ]; then echo '1=1'; fi
	if [ 1 -ne 1 ]; then echo '1=1'; else echo '1!=1'; fi
	if [ 1 -eq 2 ]; then echo 'if'; elif [ 1 -eq 1 ]; then echo 'elif'; else echo 'else'; fi

	for ((i=0; i<5; i++)); do echo 'i='"$i"; done;
	for i in {a..g}; do echo 'i='"$i"; done;

	select selected in {AA,BB}; do echo 'select is '"$selected"'.' && break; done;
	select selected in {AA,BB}; do case $selected in AA|BB) echo 'select is '"$selected"'.' && break;; esac; done;
	select selected in {AA,BB}; do case $selected in AA|BB) echo 'select is '"$selected"'.' && break;; \*) continue;; esac; done;
	#select selected in {AA,BB}; do case $selected in AA|BB) echo 'select is '"$selected"'.' && break;; \*) tput cuu 1 && tput cub 999 && continue;; esac; done;
 
	time sleep 2

	function MyFunc() { echo F; }
	MyFunc() { echo F; }
	MyFunc
}
Finalize() { rm -Rf a.txt; }
Run

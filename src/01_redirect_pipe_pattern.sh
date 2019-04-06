#!/bin/bash
#set -Ceu
#-----------------------------------------------------------------------------
# bashのメタ文字・予約語・コメント・エスケープシーケンス
# 作成日時: 2019-04-06T09:20:37+0900
# http://ytyaru.hatenablog.com/entry/2020/06/09/000000
#-----------------------------------------------------------------------------
Run() {
	Redirect
	HereDocument
	Pipe
	Finalize
}
Redirect() {
	echo StdOut
	echo StdOut 1>&1
	echo StdOut >&1
	echo StdErr 1>&2
	echo StdErr >&2
	echo StdOut > /dev/null
	{ echo StdErr >&2; } 2>/dev/null
	{ echo StdOut >&1; echo StdErr >&2; }
	{ echo StdOut >&1; echo StdErr >&2; } > /dev/null
	{ echo StdOut >&1; echo StdErr >&2; } 2> /dev/null
	{ echo StdOut >&1; echo StdErr >&2; } 1>/dev/null 2>/dev/null

#	echo StdOut > a.txt # 存在するファイルを上書きできません
	echo StdOut >| a.txt
	echo StdOut >> a.txt
	{ echo StdOut >&1; echo StdErr >&2; } 1> 1.txt 2> 2.txt
	{ echo StdOut >&1; echo StdErr >&2; } &> a.txt

	diff <(echo -e 'A\nB') <(echo -e 'A\nZ')
	exec 2> >(tee -a err.log >&2)

	{ exec 3< <(seq 1 5); cat <&3; exec 3>&-; }
	{ exec {fd}< <(seq 1 5); cat <&${fd}; exec {fd}>&-; }
	{ exec 3< <(echo -e 'A\nB\nC'); while read line <&3; do echo ${line}1; done; exec 3>&-; }
	{ exec {fd}< <(echo -e 'A\nB\nC'); while read line <&${fd}; do echo ${line}1; done; exec {fd}>&-; }

	cat <(echo 'A') > a.txt
	cat < a.txt
	cat <<- EOS
		A
		B
	EOS
	cat <<< "redirect."
}
HereDocument() {
	cat << EOS
A
B
C
EOS

	cat << EOS
~
${HOME}
$(echo AAA)
$((1+1))
EOS

	cat << 'EOS'
~
${HOME}
$(echo AAA)
$((1+1))
EOS

	cat <<- EOS
		A
		B
		C
	EOS

	VAR=$(cat <<- EOS
		A
		B
	EOS
	)
	echo "$VAR"


	while read line; do echo ${line}1; done <<- EOS
		A
		B
		C
	EOS

	{ SUM=0; while read line; do SUM=$((SUM+line)); done; echo $SUM; } <<- EOS
		1
		2
		3
	EOS
}

Pipe() {
	seq 1 5 | grep '3'

	echo -e 'A\nB\nC' | cat
	echo -e 'A\nB\nC' | grep 'B'
	echo -e 'A\nB\nC' | tr '\n' ' '
	echo -e 'A\tB\tC' | expand
	echo -e 'A\tB\tC' | expand | unexpand -a
	echo -e 'B\nA\nA' | sort | uniq > distinct.txt
	echo -e '2\t3\n1\t2' | tsort
	echo -e 'A\nB\nC' | sed -e 's/^B$/Z/g'
	echo -e 'A\nB\nC' | nl
	echo -e 'A\nB\nC' | wc -l
	echo -e 'A\nB\nC' | head -n 1
	echo -e 'A\nB\nC' | tail -n 1
	echo -e 'A\nB\nC' | sed -n 2p
	echo -e 'A\nB\nC' | sed -n 2,3p
	echo -e 'A\tB\tC' | cut -f2
	echo -e 'A\nB\nC' | awk '{ printf("%s%s\n", $1, "1"); }'
	echo {{a..z},{A..Z}} | tr -d ' ' | fold -w 26

	diff <(echo -e 'A\nB') <(echo -e 'A\nZ')
	comm <(echo -e 'A\nB') <(echo -e 'A\nZ')
	paste <(echo -e '1\n2\n3') <(echo -e 'A\nB')
	join -a 1 <(echo -e '1\n2\n3') <(echo -e '1\tA\n3\tC')
	iconv -f UTF-8 -t SJIS <(echo 'あいうえお')

	{ echo StdOut; echo StdErr >&2; } |& nl
	{ echo StdOut; echo StdErr >&2; } | nl
	{ echo StdOut; echo StdErr >&2; } 2>/dev/null | nl

	mkfifo p0; cat < p0 & echo A > p0; rm p0;
}
Finalize() { for file in 1.txt  2.txt  a.txt  distinct.txt  err.log; do rm -Rf $file; done; }
Run

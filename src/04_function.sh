#!/bin/bash
#set -Ceu
#-----------------------------------------------------------------------------
# bash bashで関数を書く
# 作成日時: 2019-04-06T11:52:23+0900
# http://ytyaru.hatenablog.com/entry/2020/06/13/000000
#-----------------------------------------------------------------------------
Ex1() { MyFunc() { echo F; }; MyFunc; }
Ex2() { function MyFunc() { echo F; }; MyFunc; }
Ex3() {
	Sum() { echo $(($1 + $2)); }
	echo $(Sum 10 20)
}
Ex4() {
	ParentDir="$(dirname $0)"
	echo "$ParentDir"
}
Ex5() {
	Msg() { echo "$@"; }
	Msg "やあ" "hello world."
}
Ex6() {
	Msg() { for msg in $@; do echo $msg; done; }
	Msg "やあ" "hello world."
}
Ex7() {
	MyFunc() { return 255; }
	MyFunc
	RET=$?
	echo $RET
}
Ex8() {
	MyFunc() { return 'A'; }
	#MyFunc
	# return: A: 数字の引数が必要です
}
GetStdout() {
	MyFunc() { echo 'RESULT'; }
	RET="$(MyFunc)"
	echo $RET
}
Local1() {
	MyFunc() { local RET="RESULT"; echo "$RET"; }
	RET="$(MyFunc)"
	echo $RET
}
Local2() {
	set -u
	MyFunc() { local RET="RESULT"; echo "$RET"; }
	echo $RET
}
Local3() {
	RET=GLOBAL
	MyFunc() { local RET="RESULT"; echo "$RET"; }
	RET="$(MyFunc)"
	echo $RET
}
Local4() {
	RET=GLOBAL
	MyFunc() { echo "$RET"; }
	RET="$(MyFunc)"
	echo $RET
}
LocalReadonly() {
	# 読み取り専用の変数です
	#MyFunc() { local -r RET="RESULT"; RET="A"; echo "$RET"; }
	#RET="$(MyFunc)"
	#echo $RET
	:
}
Readonly() {
	# 読み取り専用の変数です
	readonly RET="RESULT"
	#RET="A"
}
BadLocalReadonly() {
	# 読み取り専用の変数です
	#MyFunc() { local readonly RET="RESULT"; local readonly RET="A"; echo "$RET"; }
	#MyFunc() { local readonly RET="RESULT"; local RET="A"; echo "$RET"; }
	#MyFunc() { local readonly RET="RESULT"; RET="A"; echo "$RET"; }
	#RET="$(MyFunc)"
	#echo $RET
	:
}
Run() {
	Ex1
	Ex2
	Ex3
	Ex4
	Ex5
	Ex6
	Ex7
	Ex8
	GetStdout
	Local1
	Local2
	Local3
	Local4
	Readonly
	LocalReadonly
	BadLocalReadonly
}
Run

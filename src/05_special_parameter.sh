#!/bin/bash
#set -Ceu
#-----------------------------------------------------------------------------
# bashの特殊パラメータ
# 作成日時: 2019-04-06T12:49:52+0900
# http://ytyaru.hatenablog.com/entry/2020/06/15/000000
#-----------------------------------------------------------------------------
Here() { echo "$0"; }
Filename() { echo "$(basename "$0")"; }
DirPath() { echo $(cd $(dirname "$0"); pwd); }
FullPath() { echo "$(cd $(dirname "$0"); pwd)/$(Filename)"; }
ShowParams() {
	echo "ParamNum: $#"
	echo "Params: '$*'"
	local count=1
	for p in $@; do echo "$count: $p"; ((count++)); done;
}
Result() {
	[[ 1 -eq 1 ]] && echo "True: $?" || echo "False: $?"
	[[ 1 -ne 1 ]] && echo "True: $?" || echo "False: $?"
}
Run() {
	echo "$_"
	# bash実行時のフラグ
	echo "$-"
	echo "$BASHPID"
	# シェルのPID
	echo "$$"
	# 直前に実行したバックグラウンドコマンドのPID
	echo "$!"
	Here
	Filename
	DirPath
	FullPath
	ShowParams A B C
	Result
	echo "$_"
}
Run

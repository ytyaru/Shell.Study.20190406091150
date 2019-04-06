#!/bin/bash
#set -Ceu
#-----------------------------------------------------------------------------
# bash コプロセス（coproc）
# 作成日時: 2019-04-06T11:29:45+0900
# http://ytyaru.hatenablog.com/entry/2020/06/11/000000
#-----------------------------------------------------------------------------
Run() {
	coproc CP { sleep 2; echo 'AAA'; }
	read var <&"${CP[0]}"
	echo "$var"

	coproc CP { sleep 2; awk '{print "AWK: " $0; fflush();}'; }
	echo arg0 >&"${CP[1]}"
	read var <&"${CP[0]}"
	echo "$var"

	rm -Rf CP
}
Run

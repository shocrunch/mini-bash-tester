#!/bin/bash
shopt -s expand_aliases

PASS_COLOR="\e[32m"
PASS_COLOR_END="\e[m"
ERR_COLOR="\e[31;1m"
ERR_COLOR_END="\e[m"
BOLD="\e[1m"
BOLD_END="\e[m"
LINE_NO=
ALL_TEST_COUNT=0
PASSED_TEST_COUNT=0
TEST_CASE_NAME=

alias count_tests="ALL_TEST_COUNT=$(cat $0 | grep ^fail_unless_ | wc | awk '{print $1}')"

trap '_print_result' EXIT
_print_result()
{
	echo -e ">"
	if [ $ALL_TEST_COUNT -gt 0 ]; then
		echo -e "> ${BOLD}Test result: ${PASSED_TEST_COUNT}/${ALL_TEST_COUNT} tests passed.${BOLD_END}"
	else
		echo -e "> ${BOLD}Test result: $PASSED_TEST_COUNT tests passed.${BOLD_END}"
	fi
	echo -e ">"
}

err_msg()
{
	if [ "${TEST_CASE_NAME}" ]; then
		echo -e ${ERR_COLOR}Test failed${ERR_COLOR_END}: ${BOLD}${TEST_CASE_NAME}${BOLD_END}: line=$LINE_NO: want=$want but target=$target
	else
		echo -e ${ERR_COLOR}Test failed${ERR_COLOR_END}: line=$LINE_NO: want=$want but target=$target
	fi
}

alias fail_unless_equals_num='LINE_NO=$LINENO _fail_unless_equals_num'
_fail_unless_equals_num()
{
	local target=$1
	local want=$2

	if [ $target -ne $want ]; then
		err_msg
		exit 1
	else
		PASSED_TEST_COUNT=$(($PASSED_TEST_COUNT + 1))
	fi

	return 0
}

alias fail_unless_equals_str='LINE_NO=$LINENO _fail_unless_equals_str'
_fail_unless_equals_str()
{
	local target=$1
	local want=$2

	if [ x"$target" != x"$want" ]; then
		err_msg
		exit 1
	else
		PASSED_TEST_COUNT=$(($PASSED_TEST_COUNT + 1))
	fi
	return 0
}


#!/bin/bash

source ../test_utils.sh
source ./testee.sh

TEST_CASE_NAME="normal tests"
str=$(print_with_header "Hello")
fail_unless_equals_str "$str" "Header: Hello"

TEST_CASE_NAME="abnormal tests"
str=$(print_with_header)
fail_unless_equals_num $? 1

str=$(print_with_header "")
fail_unless_equals_num $? 1     # Fails in this line.


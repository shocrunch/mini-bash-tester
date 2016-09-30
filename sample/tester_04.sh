#!/bin/bash

source ../test_utils.sh
source ./testee.sh

count_tests

str=$(print_with_header "Hello")
fail_unless_equals_str "$str" "Header: Hello"

str=$(print_with_header)
fail_unless_equals_num $? 1

str=$(print_with_header "")
fail_unless_equals_num $? 1     # Fails in this line.


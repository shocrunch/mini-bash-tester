#!/bin/bash

source ../test_utils.sh
source ./testee.sh

return_zero
fail_unless_equals_num $? 0

string=$(echo_foo)
fail_unless_equals_str "$string" "foo"

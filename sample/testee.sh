#!/bin/bash

return_zero()
{
	return 0
}

echo_foo()
{
	echo foo
}

print_with_header()
{
	if [ $# -eq 0 ]; then
		return 1
	else
		printf "Header: $@\n"
		return 0
	fi
}

# Mini bash tester

Bash script をテストするための小さなユーティリティです。

# 使い方

- test.sh
```
#!/bin/bash

source path/to/test_utils.sh
count_tests

testee_func() {
  # do something.
  return 0
}

testee_func
fail_unless_equals_num $? 0
```

- terminal
```
$ ./test.sh
>
> Test result: 1/1 tests passed.
>
```

# チュートリアル

`sample/` チュートリアルを参照してください。


# Mini Bash Tester Sample

`mini-bash-tester/test_utils.sh` の使用例です。

## File List

```
sample
|-- README.md      ... 本ファイル
|-- testee.sh      ... テスト対象プログラム
|-- tester_01.sh   ... 最小のテストプログラム例
|-- tester_02.sh   ... 簡単な単体テストの例
|-- tester_03.sh   ... TEST_CASE_NAME の使用例
`-- tester_04.sh   ... count_tests の使用例
```

### `testee.sh`

`testee.sh` は名の通り、*テストされる側* のプログラムです。

Mini Bash Tester は、`testee.sh` のような Bash スクリプトをテストすることができます。
`testee.sh` は関数定義のみされているべきです。

### `tester_XX.sh`

`tester_XX.sh` は名の通り、*テストする側* のプログラムです。

Mini Bash Tester は、`test_utils.sh` を `source` などで読み込むだけで使用することができます。
現在の Mini Bash Tester で使用可能な関数は以下の通りです。

- `fail_unless_equals_num`
- `fail_unless_equals_str`

## Tutorial

Mini bash tester のチュートリアルです。
`test_utils.sh` の使い方や、機能を解説します。

### テストプログラムを実行する

`sample/` ディレクトリに移動し、`tester_01.sh` を実行します。
下記のように **1 tests passed** とリザルトが表示されます。

```
$ cd mini-bash-tester/sample/
$ ./tester_01.sh
>
> Test result: 1 tests passed.
>
```

`tester_01.sh` には、1行コメントアウトされています。
このコメントを外して再度実行しましょう。

```
$ cat tester_01.sh
#!/bin/bash

source ../test_utils.sh

fail_unless_equals_num 0 0
fail_unless_equals_str "str_a" "str_b"
$ ./tester_01.sh
Test failed: line=5: want=str_b but target=str_a
>
> Test result: 0 tests passed.
>
```

- 実行結果にはテスト失敗のレポートが表示されます。
  - line:   失敗したテストの行数
  - want:   テスト対象のあるべき実行結果
  - target: テスト対象の実行結果

```
Test failed: line=5: want=str_b but target=str_a
```

また、 Mini bash tester は 1つのテストが失敗するとすぐにテストプログラムを終了するため、
先ほど成功していたテストも `Test result: 0 tests passed.` となり、実行されていません。

`tester_01.sh` をさらに変更しテストを実行しましょう。すべてのテストが通るはずです。

- 変更前
```
fail_unless_equals_str "str_a" "str_b"
```

- 変更後
```
fail_unless_equals_str "str_a" "str_a"
```

### 単体テストを行う

`tester_02.sh` では、`testee.sh` に実装されている 
`return_zero`, `echo_foo` というの2つの関数をテストしています。

まず、`testee.sh` の関数をテストするには、
Mini bash tester(`test_utils.sh`) とテストされるプログラム(`testee.sh`)を読み込みます。

次に、テスト対象によって `fail_unless_equals_num` と
`fail_unless_equals_str` を使用しテストを行います。

### `TEST_CASE_NAME` の使用例

Mini bash tester にはテストを補助する機能があります。その1つが `TEST_CASE_NAME` です。

`TEST_CASE_NAME` を使うことで「どんなテストを行っているかの情報」を
テスト失敗時のレポートに追加することができます。

- `TEST_CASE_NAME` を使っていない場合
```
Test failed: line=5: want=str_b but target=str_a
```

- `TEST_CASE_NAME` を使った場合
```
Test failed: abnormal tests: line=15: want=1 but target=0
```

`tester_03.sh` のように `fail_unless_` のテストの前に
`TEST_CASE_NAME` を書くことでレポートに情報を追加できます。

### `count_tests` の使用例

`count_tests` は tester に書かれているテスト数(`fail_unless_`の数)の総数を、
テストの結果に表示する機能です。

- `count_tests` を使っていない場合
```
Test failed: line=15: want=1 but target=0
>
> Test result: 2 tests passed.
>
```

- `count_tests` を使った場合
```
Test failed: line=15: want=1 but target=0
>
> Test result: 2/3 tests passed.
>
```

使い方は `tester_04.sh` を参考にしてください。

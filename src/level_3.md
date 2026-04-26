# 等级 3

本等级将为您提供基本的解决问题技能，例如冲突解决和从历史中恢复文件。
没有这些知识，您迟早会遇到麻烦。

以下是等级 3 的速查表。您可能还想复习一下[等级 2 速查表](./level_2.md)。

````admonish info title="速查表"
撤销和重做仓库上的最后一次操作
```sh
jj undo
jj redo
```
跟踪远程书签以便向其推送
```sh
jj bookmark track <NAME>
```
删除提交（以及指向它的书签）
```sh
jj abandon <CHANGE_ID>
```
（从指定提交）恢复（特定文件的）状态
```sh
jj restore [--from <CHANGE_ID>] [FILE_TO_RESTORE]
```
拆分凌乱的工作副本
```sh
jj commit --interactive
```
````

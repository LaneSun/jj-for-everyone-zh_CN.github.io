# 等级 1

本等级将为您提供完成工作所需的最基本技能。
它仅适用于最简单的用例，并且您是独立工作。
例如，使用 Git 仓库跟踪和提交作业的学生不需要比这更多的知识。

下面的"速查表"包含了等级 1 中最重要的命令。
用它来在开始之前预热您的大脑，并在忘记某些内容时提醒自己。

````admonish info title="速查表"
配置您的作者信息
```sh
jj config set --user user.name "Alice"
jj config set --user user.email "alice@local"
```
初始化一个仓库
```sh
jj git init <DESTINATION>
```
克隆一个已有的仓库
```sh
jj git clone <PATH_OR_URL> <DESTINATION>
```
提交您所做的更改
```sh
jj commit
```
将您的最新提交推送到 "main" 书签
```sh
jj bookmark move main --to @-
jj git push
```
````

# 初始化仓库

````admonish reset title="重置您的进度" collapsible=true
要将您的进度重置到本章开头，请运行以下命令：

```sh
curl https://jj-for-everyone.github.io/reset.sh | bash -s initialize
```
````

"仓库"是一个目录（文件夹），Jujutsu 在其中跟踪所有文件，包括子目录中的文件。
仓库通常对应一个项目，这样不相关项目的版本历史就不会相互绑定。
在本教程中，我们将使用 `~/jj-tutorial/repo` 作为我们仓库的位置。
不要把它放在别的地方，否则我后面让您运行的一些命令将无法正常工作。
（如果您不喜欢主目录中的杂乱文件，您可以随时删除它，并在继续教程时使用[重置脚本](./how_to_read.md#reset-your-progress)。）

初始化新仓库的命令是 `jj git init <DESTINATION>`。
我们使用 `cd` 将工作目录切换到新仓库。
将这些命令复制粘贴到您的终端中：

```sh
mkdir ~/jj-tutorial
jj git init ~/jj-tutorial/repo
cd ~/jj-tutorial/repo
```

让我们来检查一下我们的第一条 `jj` 命令。
`git` 是负责各种 Git 特定兼容功能的子命令。
其中之一是 `init` 命令，它初始化一个与 Git 兼容的新仓库。

"初始化仓库"是什么意思？
本质上，Jujutsu 创建了两个目录 `.git` 和 `.jj`。
它们包含了关于版本历史的所有信息。
为什么有两个目录？
`.git` 目录包含所有重要内容，以与 Git 兼容的方式存储。
`.jj` 目录包含额外的元数据，这些元数据启用了 Jujutsu 的一些高级功能。

```admonish warning
您永远不应直接操作这些目录中的文件！
它们的内容是一个结构化的数据库。
如果您破坏了数据库格式，仓库可能会损坏。
我们将在[关于远程的章节](./remote.md)中讨论第二层备份。
```

以点号开头的文件和目录默认是隐藏的，但您可以使用 `ls -a` 验证它们已创建：

```console
$ ls -a
.git  .jj
```

在上一章中，您用姓名和电子邮件地址配置了 Jujutsu。
此配置默认应用于您的所有仓库。
但是，对于我们的示例仓库，我们实际上将假装是 "Alice"，后面 "Bob" 会加入以模拟协作。
以下命令仅为这个特定的仓库执行作者配置。
无需记住这些命令，通常不需要使用它们。

```sh
# 仅将配置应用于单个仓库
#             vvvvvv
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"

# 重置已记录的全局作者信息：
jj metaedit --update-author
```

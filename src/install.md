# 安装与设置

安装 Jujutsu 的方式有很多，最佳方式取决于您的系统。
如果您完全不在意 Jujutsu 的安装方式，可以复制粘贴以下命令：

```sh
curl https://mise.run | sh
~/.local/bin/mise install-into jujutsu@latest /tmp/jj-install
mv /tmp/jj-install/jj ~/.local/bin
rm -rf /tmp/jj-install
exec $SHELL --login
```

现在运行 `jj --version` 来验证安装。
它应该打印出当前安装的 Jujutsu 版本，类似于 `jj 0.36.0-blabla`。
如果输出是错误，例如 `bash: jj: command not found...`，请打开下面的文本框。

````admonish fail title="jj: command not found..." collapsible=true
您的系统可能没有将安装目录 `~/.local/bin` 添加到 `PATH` 环境变量中。
要解决这个问题，您首先需要弄清楚您使用的是哪种 shell：

```sh
echo $SHELL
```

输出应该以 "bash" 或 "zsh" 结尾。
这就是您的 shell。
接下来，将一条将 `~/.local/bin` 添加到 `PATH` 变量的命令放入您的 shell 启动脚本中：

```sh
# 对于 bash：
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
```

```sh
# 对于 zsh：
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc
```

最后，关闭终端并打开一个新的，以使更改生效。
````

```admonish note title="安装命令说明" collapsible=true
安装软件比人们想象的要困难。
它取决于许多因素，如 CPU 架构和操作系统。
这就是为什么没有一个单一的、简单的命令可以在任何系统上安装 Jujutsu。
相反，我们首先安装另一个专门用于安装软件的程序，叫做 `mise`。
（您可以在[其网站](https://mise.jdx.dev/)上了解更多关于 mise 的信息。）
第一个命令 `curl https://mise.run | sh` 从互联网下载并运行一个脚本来为您安装 `mise`。
这有点危险，您在从互联网执行脚本时应当小心。
人们可能会在您下载的脚本中放置恶意命令。
但如果您信任提供脚本的网站所有者，这是一种方便的技术。

第二个命令运行 `mise` 将 Jujutsu 下载到一个临时目录。
我们必须指定 `mise` 二进制文件的完整路径（`~/.local/bin/mise`），因为此时我们不知道 `~/.local/bin` 是否包含在您的 `PATH` 变量中。
（相关说明请参见["终端基础"章节](./terminal_basics.md#the-path-variable)。）
`mise` 负责下载适合您操作系统和 CPU 架构的正确二进制文件。

接下来的命令将下载的二进制文件移动到 `~/.local/bin`，这是存放用户本地程序的惯用位置。
`rm -rf /tmp/jj-install`（"remove recursive force"）删除临时下载目录及其内容。

最后，`exec $SHELL --login` 重新启动您的 shell，这会使其启动脚本再次运行。
一些 Linux 发行版（如 Ubuntu）仅在 shell 启动时该目录存在的情况下才会将 `~/.local/bin` 添加到 `PATH` 变量中。
因此，在安装 Jujutsu 后重新启动 shell 是确保系统能够找到新程序的一种简单方法。

也许有些发行版**根本不**将 `~/.local/bin` 添加到 `PATH` 中，这意味着这些命令在此类系统上不起作用。
我没有听说过这样的发行版。
（如果您知道相关的发行版，请[提交 issue](https://github.com/jj-for-everyone/jj-for-everyone.github.io/issues/new)！）
您可以通过在 [shell 启动脚本](http://localhost:3210/terminal_basics.html#startup-scripts) 中扩展 `PATH` 变量来为自己解决此类问题。
```

````admonish info title="其他安装方法" collapsible=true
官方针对多种不同平台的安装说明在[这里](https://docs.jj-vcs.dev/latest/install-and-setup/)。
我也会提到一些我认为重要的方法。

如果您使用 [cargo-binstall](https://github.com/cargo-bins/cargo-binstall)，这个方法非常好用：

```sh
cargo-binstall jj-cli
```

如果您是 Mac 和 Homebrew 用户，这个方法适合您：

```sh
brew install jj
```

如果您已安装了 Rust 工具链，并希望从源代码编译，可以运行：

```sh
cargo install --locked --bin jj jj-cli
```

您也可以直接从 Jujutsu 的[发布页面](https://github.com/jj-vcs/jj/releases/latest)下载二进制文件。
向下滚动到 "Assets"，那里有一个可供下载的压缩包列表。
选择正确的压缩包取决于两点：您的操作系统和您的 CPU 架构。
在压缩包名称中查找与您系统匹配的字符串。

如何识别您的操作系统：

| 操作系统 | 要查找的字符串 |
| --- | --- |
| Linux | unknown-linux-musl |
| Mac | apple-darwin |
| Windows | pc-windows-msvc |

如何识别您的 CPU 架构：

| CPU 品牌 | 要查找的字符串 |
| --- | --- |
| Intel | x86_64 |
| AMD | x86_64 |
| Apple | aarch64 |
| ARM | aarch64 |
| Qualcom (Snapdragon) | aarch64 |

下载正确的压缩包后，您需要解压它。
您应该可以在文件资源管理器中右键单击下载的压缩包，然后在下拉菜单中选择"解压"或类似选项。
解压后的文件夹将包含文档和一个名为 "jj" 的文件。
您需要将其移动到 `~/.local/bin/` 目录。
（或者如果您知道自己在做什么，可以放到其他存放程序的位置。）
````

## Git

您还需要安装 Git。
MacOS 和大多数 Linux 发行版都预装了 Git。
如果您还没有安装，请使用您的包管理器安装，例如 `sudo apt install git`。

## 初始配置

Jujutsu 的可配置性非常高，但我们目前不关心大多数配置项。
您**必须**配置的唯一信息是您的姓名和电子邮件。
这是必要的元数据，没有这些信息，某些功能将无法正常工作。
不过，如果您不想将这些信息存储在您计划工作的仓库中，您不必输入_真实_姓名和电子邮件。

如果您正在进行学校或工作项目，配置您的真实姓名和学校/工作电子邮件通常是没问题的。
这些仓库通常不公开可访问。

如果您计划参与任何人都可以查看的开源项目，您可能需要更加谨慎。
您可以使用 GitHub 用户名作为用户名，但许多人也不介意使用真实姓名。
电子邮件地址更为重要。
如果您使用普通的私人电子邮件地址，可能会有在该地址收到不受欢迎的邮件的风险。
您可以考虑使用一个专门用于开源工作的地址。
另一个替代方案是使用 GitHub 提供的地址。
它标识您的 GitHub 账户，但您无法通过它接收电子邮件。
前往 [GitHub 的电子邮件设置](https://github.com/settings/emails) 并选择 "Keep my email address private"，您的私人电子邮件地址将会显示在顶部。

以下是配置用户名和电子邮件的命令：

```sh
jj config set --user user.name "Anonymous"
jj config set --user user.email "anon@local"
```

如果您想要 shell 补全功能，请按照[此处的说明](https://docs.jj-vcs.dev/latest/install-and-setup/#command-line-completion)操作。
如果您不知道"shell 补全"是什么，不用担心，这不重要。

## 安装一个简单的文本编辑器

Jujutsu 有时会要求您编辑文本文件。
用于此目的的默认文本编辑器在 Linux 和 Mac 上是 `nano`。
它运行良好，但对于新用户来说可能不太直观。
（<kbd>Ctrl+O</kbd> 保存文件，<kbd>Ctrl+X</kbd> 关闭程序。）

这是可选的，但我建议您安装一个名为 [edit](https://github.com/microsoft/edit) 的文本编辑器。
我认为它是最简单、最直观的替代方案。
如果您使用 `mise` 安装了 Jujutsu（如上所述），您也可以用同样的方式安装 `edit`：

```sh
mise install-into edit@latest /tmp/edit-install
mv /tmp/edit-install/edit ~/.local/bin
rm -rf /tmp/edit-install
```

如果您使用其他方法安装了 Jujutsu，您也需要自行安装 `edit`。

接下来，我们需要配置 Jujutsu 在打开文本文件时使用 `edit`：

```sh
jj config set --user ui.editor edit
```

从现在开始，当 Jujutsu 为您打开文本文件时，它将使用 `edit`。
当您编辑完文件后，点击菜单栏中的 "File"，然后点击 "Exit"，或按 <kbd>Ctrl+Q</kbd> 退出文本编辑器。
它会询问您是否要保存文件，按 <kbd>Enter</kbd> 确认。
就是这样！
在我们第一次需要它时，我会提醒您它的工作方式。

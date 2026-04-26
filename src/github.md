# 使用 GitHub（可选）

如约而至，以下是一些关于使用 [GitHub](https://github.com/) 的技巧。
如果您对此不感兴趣，请随意跳到下一章，这些内容以后不会变得相关。

我想提一下，GitHub 并非 Git 托管服务的唯一提供商，但肯定是最流行的。
不幸的是，它是专有的。
专有软件剥夺了您阅读、修改和共享其源代码的自由。
以下是一些开源 Git 托管软件和使用它们的服务提供商列表。
如果您的数字自由对您很重要，请考虑使用这些替代方案之一来托管您的仓库。

- [Forgejo](https://forgejo.org/)
- [Codeberg](https://codeberg.org/)
- [Sourcehut](https://sourcehut.org/)
- [Gerrit](https://www.gerritcodereview.com/)
- [Tangled](https://tangled.sh/)
- [Radicle](https://radicle.xyz/)

## 使用 SSH 密钥进行身份验证

Jujutsu 需要以您的 GitHub 用户身份进行身份验证，以便代表您发送和接收提交。
使用用户名和密码也可以做到，但这非常繁琐，我完全不推荐。
如果备份很繁琐，您就会**更少地**进行备份。
更少的备份意味着更大的丢失工作成果的风险！
所以让我们让身份验证尽可能无缝。

最好的身份验证方法是使用 SSH 密钥。
它比密码更方便、更安全。
GitHub 有关于如何设置的精彩文档，请按照此处的说明操作：
- [生成新的 SSH 密钥](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [将 SSH 密钥添加到您的账户](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

您可以使用以下命令验证设置：

```sh
ssh -T git@github.com
```

预期的输出是：

```
Hi user! You've successfully authenticated, but GitHub does not provide shell access.
```

## 在 GitHub 上创建一个新仓库

如果您打算使用已有的仓库，请跳到下一节。

要在 GitHub 上创建一个新仓库，[点击这里](https://github.com/new)并填写表单。
您需要做的就是选择一个所有者（可能是您的用户名）和一个仓库名称。
还要检查可见性是否匹配您的需求（以后可以更改）。

如果您已经有一个包含内容的本地仓库，并希望将其推送到这个新远程，请确保**不要使用任何内容初始化仓库**。
这意味着，不要模板、不要 README、不要 `.gitignore`，也不要许可证。

最后，点击 "Create repository"。

## 克隆已有仓库

在浏览器中导航到已有仓库的页面。
点击显示 "Code" 的绿色按钮。
在下拉菜单中选择 **SSH**（假设您已按上述说明设置了 SSH 密钥）。
复制显示的 URL。

![](./github_ssh_url.png)

最后，将 URL 粘贴到 Jujutsu 的克隆命令中：

```sh
jj git clone <COPIED_URL>
```

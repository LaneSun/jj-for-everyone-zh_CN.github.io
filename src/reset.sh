#!/usr/bin/env bash
set -euxo pipefail

red='\033[0;31m'
blue='\033[0;34m'
no_color='\033[0m' # No Color

error="${red}Error:${no_color}"
hint="${blue}Hint:${no_color}"

# The env variable JJ_TUTORIAL_DIR can be used to override the location of the
# tutorial repository. This is *intentionally not documented* in the tutorial,
# because doing so can lead to problems. For simplicity, the tutorial will
# continue to use the hardcoded path in code snippets to copy-paste into the
# terminal. If the location is changed, those code snippets will have to be
# adjusted manually. The feature is still there for opinionated folk who know
# what they're doing.
jj_tutorial_dir=${JJ_TUTORIAL_DIR:-$HOME/jj-tutorial}

if [ "${1:-x}" = "x" ] ; then
    set +x
    printf "$error Please provide the chapter keyword as the first argument.\n"
    exit 1
fi
chapter="$1"

function success() {
    set +x
    echo "✅ Reset script completed successfully! ✅"
    exit 0
}

rm -rf "$jj_tutorial_dir"

if [ "$chapter" = install ] ; then success ; fi

if ! command -v jj > /dev/null ; then
    set +x
    printf "$error Jujutsu doesn't seem to be installed.\n"
    printf "       Please install it and rerun the script.\n"
    exit 1
fi

# make sure jj version is recent enough
detected_version="$(jj --version | cut -c 4-7)"
required_version="0.38"
if [ "$detected_version" -lt "$required_version" ] ; then
    set +x
    printf "$error Your Jujutsu version ($detected_version) is too outdated.\n"
    printf "       Please update to version $required_version or later.\n"
    printf "$hint If you installed Jujutsu with mise, as recommended in the installation\n"
    printf "      chapter, use the following commands to update:\n"
    echo "
mise install-into jujutsu@latest /tmp/jj-install
mv /tmp/jj-install/jj ~/.local/bin
rm -rf /tmp/jj-install"
    exit 1
fi

# Ensure existing user configuration does not affect script behavior.
export JJ_CONFIG=/dev/null
export GIT_CONFIG_GLOBAL=/dev/null

if [ "$chapter" = initialize ] ; then success ; fi

mkdir "$jj_tutorial_dir"
jj git init "$jj_tutorial_dir"/repo
cd "$jj_tutorial_dir"/repo

jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj metaedit --update-author

if [ "$chapter" = log ] ; then success ; fi

if [ "$chapter" = make_changes ] ; then success ; fi

echo "# jj-tutorial" > README.md
jj log -r 'none()' # trigger snapshot

if [ "$chapter" = commit ] ; then success ; fi

jj commit --message "添加包含项目标题的 readme

It's common practice for software projects to include a file called
README.md in the root directory of their source code repository. As the
file extension indicates, the content is usually written in markdown,
where the title of the document is written on the first line with a
prefixed \`#\` symbol.
"

if [ "$chapter" = remote ] ; then success ; fi

git init --bare -b main "$jj_tutorial_dir"/remote
jj git remote add origin "$jj_tutorial_dir"/remote
jj bookmark create main --revision @-
jj git push --bookmark main

if [ "$chapter" = update_bookmark ] ; then success ; fi

printf "\n这是一个用于学习 Jujutsu 的玩具仓库。\n" >> README.md
jj commit -m "向 readme 添加项目描述"

jj bookmark move main --to @-

jj git push

if [ "$chapter" = clone ] ; then success ; fi

cd ~
rm -rf "$jj_tutorial_dir"/repo
jj git clone "$jj_tutorial_dir"/remote "$jj_tutorial_dir"/repo
cd "$jj_tutorial_dir"/repo
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj metaedit --update-author

if [ "$chapter" = github ] ; then success ; fi

if [ "$chapter" = branch ] ; then success ; fi

echo 'print("Hello, world!")' > hello.py

jj commit -m "添加用于问候世界的 Python 脚本

打印文本 \"Hello, world!\" 是编程入门课程中的经典练习。它几乎可以用任何
语言轻松完成，同时让学生感到成就感并对后续内容产生好奇心。"

jj git clone "$jj_tutorial_dir"/remote "$jj_tutorial_dir"/repo-bob
cd "$jj_tutorial_dir"/repo-bob
jj config set --repo user.name Bob
jj config set --repo user.email bob@local
jj metaedit --update-author

echo "# jj-教程

文件 hello.py 包含一个问候世界的脚本。
可以通过命令 'python hello.py' 来执行。
编程很有趣！" > README.md
jj commit -m "在 README.md 中记录 hello.py

文件 hello.py 尚不存在，因为 Alice 正在处理它。
一旦我们的更改被合并，这份文档就会变得准确。"

jj bookmark move main --to @-
jj git push

cd "$jj_tutorial_dir"/repo
jj bookmark move main --to @-
jj git fetch

if [ "$chapter" = show ] ; then success ; fi

if [ "$chapter" = merge ] ; then success ; fi

jj new main@origin @-

jj commit -m "合并 hello-world 的代码和文档"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = ignore ] ; then success ; fi

cd "$jj_tutorial_dir"/repo-bob

tar czf submission_alice_bob.tar.gz README.md

echo "
## 提交说明

运行以下命令来创建提交压缩包：

~~~sh
tar czf submission_alice_bob.tar.gz [FILE...]
~~~" >> README.md

jj show > /dev/null

echo "*.tar.gz" > .gitignore

jj file untrack submission_alice_bob.tar.gz

jj commit -m "添加提交说明"

if [ "$chapter" = rebase ] ; then success ; fi

jj bookmark move main --to @-
jj git fetch
jj rebase --onto main@origin
jj git push

if [ "$chapter" = more_bookmarks ] ; then success ; fi

cd "$jj_tutorial_dir"/repo

echo 'for (i = 0; i < 10; i = i + 1):
    print("Hello, world!")' > hello.py

jj commit -m "WIP：添加 for 循环（需要修复语法）"

jj git push --change @-

if [ "$chapter" = navigate ] ; then success ; fi

jj git fetch
jj new main
jj new 'description(substring:"在 README.md 中记录 hello.py")'
jj new main

if [ "$chapter" = undo ] ; then success ; fi

echo 'print("Hallo, Welt!")' >> hello.py
echo 'print("Bonjour, le monde!")' >> hello.py

jj commit -m "代码改进"

jj undo

jj commit -m "同时打印德语和法语的问候语"

jj undo
jj undo
jj undo

jj redo
jj redo
jj redo

if [ "$chapter" = track ] ; then success ; fi

cd ~ # move out of the directory we're about to delete
rm -rf "$jj_tutorial_dir"/repo
jj git clone "$jj_tutorial_dir"/remote "$jj_tutorial_dir"/repo
cd "$jj_tutorial_dir"/repo

# roleplay as Alice
jj config set --repo user.name "Alice"
jj config set --repo user.email "alice@local"
jj metaedit --update-author

echo 'print("Hallo, Welt!")' >> hello.py
echo 'print("Bonjour, le monde!")' >> hello.py
jj commit -m "同时打印德语和法语的问候语"

jj bookmark move main -t @-
jj git push

jj bookmark track 'push-*'

if [ "$chapter" = conflict ] ; then success ; fi

jj new 'description(substring:"WIP：添加 for 循环")'

echo 'for _ in range(10):
    print("Hello, world!")' > hello.py

jj commit -m "修复循环语法"

jj new main @-

echo 'for _ in range(10):
    print("Hello, world!")
    print("Hallo, Welt!")
    print("Bonjour, le monde!")' > hello.py

jj commit -m "合并问候语的重复和翻译"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = abandon ] ; then success ; fi

jj commit -m "实验：迁移到闪亮的新框架"
jj git push --change @-
jj new main
jj commit -m "实验：使用微服务提高可扩展性"
jj git push --change @-
jj new main
jj commit -m "实验：应用 SOLID 设计模式"
jj git push --change @-
jj new main

jj abandon 'description(substring:"实验：")'

jj git push --deleted

if [ "$chapter" = restore ] ; then success ; fi

rm README.md
jj show &> /dev/null

jj restore README.md

jj restore --from 'description(substring:"修复循环语法")' hello.py

jj commit -m "移除翻译"
jj bookmark move main --to @-
jj git push

if [ "$chapter" = commit_interactive ] ; then success ; fi

# `jj commit --interactive doesn't work in a script, so we reproduce the same
# commits a little differently.
echo "实现任务 1" > task_1.txt
jj commit --message "实现任务 1" task_1.txt
echo "实现任务 2" > tasks_2_and_3.txt
jj commit --message "实现任务 2"
echo "实现任务 3" >> tasks_2_and_3.txt
jj commit --message "实现任务 3"

jj bookmark move main --to @-
jj git push

if [ "$chapter" = complete ] ; then success ; fi

set +x
echo "Error: Didn't recognize the chapter keyword: '$chapter'."
exit 1

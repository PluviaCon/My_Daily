<!--ts-->
<!--te-->

# ubuntu 脱坑 & 日常

- [ubuntu 脱坑 & 日常](#ubuntu-脱坑--日常)
  - [系统安装](#系统安装)
  - [常用软件](#常用软件)
  - [环境](#环境)
  - [注意提示](#注意提示)
  - [Shell](#shell)
    - [常用命令](#常用命令)
    - [系统类](#系统类)
      - [**外部命令&内部命令**](#外部命令内部命令)
      - [**环境变量**](#环境变量)
      - [**文件权限**](#文件权限)
    - [shell 基础](#shell-基础)
      - [**重新定向输入和输出**](#重新定向输入和输出)
      - [**结构化命令**](#结构化命令)
  - [构造函数&原型对象](#构造函数原型对象)
    - [constructor **_属性_**](#constructor-属性)
    - [prototype **_属性_**](#prototype-属性)
    - [ES6 class](#es6-class)
    - [变量值类型](#变量值类型)
  - [React 渲染&优化](#react-渲染优化)
  - [Meteor](#meteor)
    - [RocketChat API](#rocketchat-api)
    - [目录结构](#目录结构)
    - [meteor 路由](#meteor-路由)
    - [meteor 模板,[解释](https://segmentfault.com/a/1190000003781596)](#meteor-模板解释)
    - [Collection 数据集合](#collection-数据集合)
    - [Methods RPC 协议实现方法](#methods-rpc-协议实现方法)
    - [Meteor Package](#meteor-package)
  - [Nginx & certbot & Jitsi Meet](#nginx--certbot--jitsi-meet)
    - [HTTP 和反向代理服务器](#http-和反向代理服务器)
    - [SSL 简化申请流程](#ssl-简化申请流程)
    - [Jitsi Meet 安装](#jitsi-meet-安装)
  - [Kubernetes && [Docker](http://guide.daocloud.io/dcs/docker-9152673.html)](#kubernetes--docker)
    - [Kubernetes 中文文档 [模型文档](https://kubernetes.io/docs/reference/federation/v1/definitions/)](#kubernetes-中文文档-模型文档)
    - [安装示例&注意事项](#安装示例注意事项)
      - [常用](#常用)
      - [单节点](#单节点)
      - [多节点高可用](#多节点高可用)
  - [Redis](#redis)
    - [安装(Ubuntu18.0.4)](#安装ubuntu1804)
    - [命令(String 类型)](#命令string-类型)
  - [MYSQL](#mysql)
  - [Java](#java)
    - [关键字](#关键字)
    - [识别符](#识别符)
    - [数据类型&变量](#数据类型变量)
      - [声明变量](#声明变量)
      - [基本数据类型](#基本数据类型)
      - [数组](#数组)
      - [字符串](#字符串)
  - [Python](#python)
    - [安装库及常用框架](#安装库及常用框架)
  - [Odoo](#odoo)
  - [参考资料](#参考资料)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

## 系统安装

-   win10 下空出分区，以便 ubuntu 安装
-   设置 BIOS 为 U 盘自启动
-   18.04 下，选择英文安装，与 win10 共存（分区意义不大）
    [英文安装下设置中文](https://blog.csdn.net/qq_19339041/article/details/80058575),好处是使用英文路径
-   等到中文设置完成后，安装搜狗输入法.
    [中文乱码解决](https://blog.csdn.net/s_lisheng/article/details/79620131),需要重启，并在输入法配置里`Fcitx Config`将搜狗拼音移动到第一项

## 常用软件

-   **[蓝灯](https://github.com/getlantern/lantern)**
-   **[chrome](https://www.google.com/intl/zh-CN_ALL/chrome/)**
-   **[vscode](https://code.visualstudio.com/)**
-   **[shutter](http://shutter-project.org/downloads/)**
-   **vim**
-   **git**
-   **[node&npm](https://github.com/creationix/nvm#installation)**
-   **印象笔记插件（网页版）**

## 环境

-   `/opt`目录： **_可选的程序_**
-   `/etc`目录： **_各种系统配置文件_**
    -   `/etc/profile` ：**为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行**
    -   [配置设置](https://my.oschina.net/qinlinwang/blog/30471)
    -   [更多设置](https://blog.csdn.net/White_Idiot/article/details/78253004)
-   [各个目录功能介绍](https://www.cnblogs.com/yudar/p/5809219.html)

## 注意提示

-   github 密码修改后，更新 ssh 秘钥并在网页更新(不行用邮箱名登录 F\*\*\*)
    [设置](https://blog.csdn.net/hd_feng/article/details/78353146),[修改](https://git-scm.com/book/zh/v1/%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E7%9A%84-Git-%E7%94%9F%E6%88%90-SSH-%E5%85%AC%E9%92%A5)
-   > git pull 拉取线上代码
    > git stash 存栈
    > git add 添加代码
    > git stash pop 出栈
    > git branch 查看分支
    > git commit -m "本次备注"
    > git checkout 切换分支
    > vim .gitignore 查看/设置不提交文件夹
    > 先拉取线上代码,判断是否存在冲突,有则存栈,然后在拉取代码,然后出栈.
    > 通过 git status 查看仓库的状态
    > 确认提交分支正确,然后备注本次修改内容,然后提交(push)
    > 若遇到 elline 语法问题 ,尝试 git commit --no-verify -m "修改"
    > git log 查看版本
    > git reset --hard HEAD^ 本地仓库回到指定仓库
    > git push -f 覆盖远程仓库版本(撤销操作)

-   启动 java 时注意端口有无被占用,[查看进程](https://blog.csdn.net/hongweideng/article/details/78424866)
-   ESlint 语法规则问题，[官网](https://eslint.org/)大多有解释,补充：
    > ESLint Parsing error: Unexpected token 问题
    > 无`babel-eslint` 包 ，[详情](https://stackoverflow.com/questions/36001552/eslint-parsing-error-unexpected-token)
-   vsCode Debug Meteor 问题
    -   安装插件
    -   [配置 lanuch.json](https://forums.meteor.com/t/meteor-1-6-server-debugging-with-vs-code/39821)
    -   尝试更新 Meteor 包到`18.1`或最新版本
-   `markdown-preview-enhanced` 可以修改预览样式和生成样式

    -   预览：`ctrl+shift+p`命令打开`Markdown Preview Enhanced: Customize Css`
    -   生成：
        > ~/.vscode/extensions/shd101wyy.markdown-preview-enhanced-0.3.5/node_modules/@shd101wyy/mume/styles/preview_theme/github-light.css
        > 修改完成后刷新

-   `f.lux 安装` [下载](http://blog.topspeedsnail.com/archives/4691),注意 PPA 格式
-   `属性访问注意` 当属性名是循环或是获取时,多为字符串类型,用 **`.`** 访问为`undefined`. 使用`[]`[访问](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Property_Accessors),可以取到

    ```js
    if (typeof content[key] == 'string' && content[key].includes('其他')) {
        content[key] = content[key].split(',');
        self.setState({ [key]: true });
    }
    ```

-   一个`getFieldDecorator`下注册多个`child`,两种形式,

    -   [封装组件形式](https://github.com/ant-design/ant-design/issues/3864),在设置值时,没试过,可以借鉴
    -   控制 state 形式(选中||未选中场景):

    ```js
      <FormItem {...checkbox} label="具体风险描述">
        {getFieldDecorator("descriptionInForceMajeure", {
          rules: [
            {
              required: false,
              message: "请选择/填写描述"
            }
          ]
        })(
          <CheckboxGroup
            style={{ paddingLeft: "1rem" }}
            options={checkboxOptions1}
            onChange={this.checkboxChang1}
          />
        )}
        { this.state.descriptionInForceMajeure ? getFieldDecorator("descriptionInForceMajeureInput", {
          rules: [
            {
              required: true,
              message: "请选择/填写描述"
            }
          ]
        })(<Input />):null}
      </FormItem>
    <FormItem {...checkbox} label="风险规避措施">...
    ```

    注意,在 `setFieldsValue()`里要对应每个注册表名 `name` 相同 ,在不同周期,注意`setState`,注意`setFieldsValue` 本质是调用外层`wrapper` 的 `setState`

-   antd 里 `Modal`组件下,默认`zIndex`属性为 1000,不设置的话,默认关闭是打开顺序.
    在里面嵌套组件时,需要特别注意(大坑!!!)

    ```js
    //options设置!!
    const ModalOpits2 = {
        title: 'Schedule details',
        footer: null,
        centered: true,
        width: '30rem',
        // zIndex: 11111,
        visible: this.state.detvisible,
        onCancel: this.setDetailOff,
        mask: false,
        destroyOnClose: true,
    };
    //嵌套
    <Modal {...ModalOpits2}>
        <Form onSubmit={this.handleSubmit}>
            <FormItem {...formItemLayout} label='Where Dates ?'>
                <span className='ant-form-text'>{this.state.showNums}</span>
            </FormItem>
            <FormItem label='SelectBadgeType' {...formItemLayout}>
                {getFieldDecorator('badgeType', {
                    initialValue: 'success',
                    rules: [{ required: false, message: '请选择日程类型' }],
                })(
                    <Select
                        // disabled={this.state.showText}
                        onChange={this.handleSelectChange}>
                        {options}
                    </Select>
                )}
            </FormItem>
            <FormItem label='Schedule details' {...formItemLayout}>
                {getFieldDecorator('Details', {
                    initialValue: this.state.nowtextcont,
                    rules: [{ required: true, message: '请填写详情内容' }],
                })(<TextArea disabled={this.state.showText} autosize={{ minRows: 2, maxRows: 6 }} />)}
            </FormItem>
            <FormItem wrapperCol={{ span: 12, offset: 8 }}>
                <Button type='primary' htmlType='submit'>
                    Submit
                </Button>
            </FormItem>
        </Form>
    </Modal>;
    ```

-   antd [引入 Map 组件](https://github.com/ElemeFE/react-amap)时,可以引入原生 Map 对象，使用其[方法](https://lbs.amap.com/api/javascript-api/reference/map)具体[配置](https://elemefe.github.io/react-amap/components/map#%E6%89%A9%E5%B1%95%E5%B1%9E%E6%80%A7)
    但是要注意,引入的原声对象,是不是相应的实例(如 Map 地图实例或者是导航实例),如果不是,使用`window.AMap`获取原生类,然后`new 你想要的实例`

## [Shell](http://man.linuxde.net/shell-script)

### 常用命令

-   `npm`
-   `ip addr`
-   `sudo` 命令，权限高 (**_Super user do_**)
-   `ls` 当前目录下所有文件夹, `ls -l & ls -a` (**_详细文件信息和全部文件信息包括隐藏_**)
-   `ctrl + :` 查看剪切板信息(快捷键)
-   `cd & rm & mkdir & cp` (**_进入目录 删除文件-f 表示强制 创建目录 复制文件_**)
-   `find` (**_查找文件， /表示查找的起始目录_**)
-   `tar & dpkg` (`tar -zxvf`解压文件名 -C 要复制到的文件目录 & dpkg -i .deb 文件 一般用于安装)
-   `source /etc/bashrc` `source`用于执行`shell`文件,其他[方法和区别](https://blog.csdn.net/u012336923/article/details/50474692)
-   `netstat -ano|findstr "3000"` && `Tskill 1796` win 下的 cmd 查看端口命令
-   `apt` 命令， 安装包管理工具，apt-get 的缩写(**_Advanced Packaging Tool_**),
    -   `apt update`(**_更新软件源中的所有软件列表_**)
    -   `apt install`(**_安装指定软件_**) `install -f` 强制安装 ; `install -y` 忽略缺失
    -   `apt remove`(卸载指定软件)
-   `curl` 命令， 网络工具，[基本用法](https://www.cnblogs.com/linjiqin/p/5484910.html)
-   `free` 查看内存
-   `df -h` 硬盘
-   `cat /proc/cpuinfo` 查看核信息
-   `cat /etc/redhat-release` 查看版本信息
-   `cat /etc/sysconfig/network-scripts/ifcfg-ens ...` 查看网卡信息 , `service network restart` 重启网络 , `/etc/resolv.conf` 查看 DNS ,`netstat -rn` 查看路由
    注意,如果 ping 某一个网址或 ip 时不通,但是 ping 本地网络可以,不是网络问题,是 ping 的端口被禁止了.测试:
    `wget www.baidu.com && cat index.html`,如果可以下载,就是 ping 端口被禁止

### 系统类

> 当程序运行在系统上时,我们称之为进程(process)

`ps -ef`查看详细的进程信息,具体内容 (docker ps -a)

-   UID:启动这些进程的用户.
-   PID:进程的进程 ID.
-   PPID:父进程的进程号(如果该进程是由另一个进程启动的)
-   C:进程生命周期中的 CPU 利用率.
-   STIME:进程启动时的系统时间.
-   TTY:进程启动时的终端设备.
-   TIME:运行进程需要的累计 CPU 时间.
-   CMD:启动的程序名称.

`详细参数`

| 参数 | 描述                                                    |
| ---- | ------------------------------------------------------- |
| -A   | 显示所有进程                                            |
| -N   | 显示与指定参数不符的所有进程                            |
| -a   | 显示除控制进程(session leader )和无终端进程外的所有进程 |
| -d   | 显示除控制进程外的所有进程                              |
| -e   | 显示所有进程                                            |
| -C   | cmdlist 显示包含在 cmdlist 列表中的进程                 |
| -G   | grplist 显示组 ID 在 grplist 列表中的进程               |
| -U   | userlist 显示属主的用户 ID 在 userlist 列表中的进程     |
| -g   | grplist 显示会话或组 ID 在 grplist 列表中的进程         |
| -p   | pidlist 显示 PID 在 pidlist 列表中的进程                |
| -s   | sesslist                                                |
| -t   | ttylist 显示终端 ID 在 ttylist 列表中的进程             |
| -u   | userlist 显示有效用户 ID 在 userlist 列表中的进程       |
| -F   | 显示更多额外输出(相对 -f 参数而言)                      |
| -O   | format 显示默认的输出列以及 format 列表指定的特定列     |
| -M   | 显示进程的安全信息                                      |
| -c   | 显示进程的额外调度器信息                                |
| -f   | 显示完整格式的输出                                      |
| -j   | 显示任务信息                                            |
| -l   | 显示长列表                                              |
| -o   | format 仅显示由 format 指定的列                         |
| -y   | 不要显示进程标记(process flag,表明进程状态的标记)       |
| -Z   | 显示安全标签(security context) 1 信息                   |
| -H   | 用层级格式来显示进程(树状,用来显示父进程)               |
| -n   | namelist 定义了 WCHAN 列显示的值                        |
| -w   | 采用宽输出模式,不限宽度显示                             |
| -L   | 显示进程中的线程                                        |
| -V   | 显示 ps 命令的版本号                                    |

> top 命令跟 ps 命令相似,能够显示进程信息,但它是实时显示的

`top` 命令显示时,第一部分显示的是系统的概况:
第一行显示了当前时间、系统的运行时间、登录的用户数以及系统的平均负载
第二行显示了进程概要信息—— top 命令的输出中将进程叫作`任务(task)`:有多少进程处在
运行、休眠、停止或是僵化状态(僵化状态是指进程完成了,但父进程没有响应)
第三行显示了 CPU 的概要信息. top 根据进程的属主(用户还是系统)和进程的状态(运行、
空闲还是等待)将 CPU 利用率分成几类输出
紧跟其后的两行说明了系统内存的状态. 第一行说的是系统的物理内存:总共有多少内存,
当前用了多少,还有多少空闲. 后一行说的是同样的信息,不过是针对系统交换空间(如果分配
了的话)的状态而言的

`grep` 命令提供搜索文件内容功能,参数常用有`-n` :行号 `-v` :反向搜索(不匹配的) `-c` :匹配个数
`-e` :多个匹配,支持正则,或是用`egrep`,具体参数可以用`man grep`来查看

`coproc` 命令,后台创建一个子 shell,并在子 shell 运行这个命令.注意,生成子 shell 的成本不低,而且速度还慢

```shell
  coproc sleep 10
  coproc Nidajobs(sleep 10;echo 嘻嘻haha)
  #通过jobs查看后台运行的进程,或是jobs -l
```

#### **外部命令&内部命令**

内建命令和非内建命令的操作方式大不相同

**外部命令** 也叫文件系统命令,是存在于 bash shell 之外的程序. 它们并不是 shell 程序的一部分. 外部命令程序通常位于`/bin`、`/usr/bin`、`/sbin`或`/usr/sbin`中,`ps` 命令也是中外部命令

当外部命令执行时,会创建出一个子进程. 这种操作被称为衍生(forking). 外部命令 ps 很方便显示出它的父进程以
及自己所对应的衍生子进程

**内建命令** 内建命令和外部命令的区别在于前者不需要使用子进程来执行. 它们已经和 shell 编译成了一
体,作为 shell 工具的组成部分存在,不需要借助外部程序文件来运行

#### **环境变量**

`环境变量(environment variable)` 用来存储有关 shell 会话和工作环境的信息,也可以用来存储持久数据,以便程序或脚本可以很快访问,一般是路径.分为,`全局变量` 和 `局部变量`

**`全局环境变量`** 对于 shell 会话和所有生成的子 shell 都是可见的,局部变量对创建它们的 shell 可见,系统环境变量基本上都是使用全大写字母,以区别于普通用户的环境变量,用`env` 或是 `printenv` 查看

**`局部环境变量`** 局部环境变量只能在定义它们的进程中可见,`set` 命令会显示为某个特定进程设置的所有环境变量,包括局部变量、全局变量以及用户定义变量

设置变量,应注意全局变量和局部变量的命名区别,全局变量用大写字符,局部变量为小写.并且注意 shell 的层级,即是父 shell 或是子 shell 运行的变量

```shell
  echo $testname
  #输出空
  testname=Hello OR testname="Hello World"
  #注意变量名和等号和值之间不能有空格
  #全局变量的区别就是有无 export 导出
  testname="嘻嘻 哈哈"
  export testname
  echo testname
  # 在父shell穿件的全局变量可在子shell用,在子shell修改变量后,父shell变量值不会改变
  my_variable="I am Global now"
  export my_variable
  echo $my_variable
  bash
  echo $my_variable
  my_variable="Null"
  echo $my_variable
  exit
  exit
  echo $my_variable
```

**`unset`** 命令用来删除环境变量,和修改变量一样,在子 shell 中删除全局变量后,你无法将效果反映到父 shell 中

在启动文件或环境文件设置默认启动`bash shell` 的方式,登录 Linux 系统室,shell 会在五个文件读取命令:

-   `/etc/profile` 系统上默认的 bash shell 的主启动文件
-   `$HOME/.bash_profile` 下面四个是针对每个用户执行的启动文件
-   `$HOME/.bashrc`
-   `$HOME/.bash_login`
-   `$HOME/.profile`

环境变量持久化,最好是在`/etc/profile.d`目录中创建一个以`.sh`结尾的文件. 把所有新的或修改过的全局环境变
量设置放在这个文件中.在大多数发行版中,存储个人用户永久性 bash shell 变量的地方是`$HOME/.bashrc`文件. 这一点适用于所有类型的 shell 进程. 但如果设置了`BASH_ENV` 变量,那么记住,除非它指向的是`$HOME/.bashrc`,否则你应该将非交互式 shell 的用户变量放在别的地方.

#### **文件权限**

使用`ls -l` 查看目录或文件的权限信息

```shell
  ls -l
  #总用量 20
  #-rw-rw-r-- 1 kongyu kongyu 13974 5月  11  2018 index.html
  #drwx------ 2 kongyu kongyu  4096 1月  18 16:24 js
```

第一个字段一般用于描述文件和目权限的编码, `-` 代表文件,`r` 代表可读写,`w` 代表可写入,`x` 代表可执行(一般用于目录):

`-rw-rw-r--` 就代表.从第二个字段开始,`rw-` 文件属主(用户)权限为可读写,`rw-` 代表属组成员的权限为可读写,`r--` 代表其他用户的权限为只可读

**Linux 文件权限码**

| 权限 | 二进制值 | 八进制值 | 描述             |
| :--: | :------: | :------: | :--------------- |
| ---  |   000    |    0     | 没有任何权限     |
| --x  |   001    |    1     | 只有执行权限     |
| -w-  |   010    |    2     | 只有写入权限     |
| -wx  |   011    |    3     | 有写入和执行权限 |
| r--  |   100    |    4     | 只有读取权限     |
| r-x  |   101    |    5     | 有读取和执行权限 |
| rw-  |   110    |    6     | 有读取和写入权限 |
| rwx  |   111    |    7     | 有全部权限       |

**修改权限**

`chmod` 命令用来改变文件和目录的安全性设置,可以用八进制模式或符号模式修改
`chmod options mode file` `[ugoa...][[+-=][rwxXstugo...]`

**改变所属关系**

`chown` 命令用来改变文件的属主, `chgrp` 命令用来改变文件的默认属组

### shell 基础

> #!/bin/bash

shell 脚本会处理第一行注释,`#` 号后的`!`会告诉 shell 用哪个 shell 运行脚本

shell 脚本中定义的变量会一直保持着它们的值,但在 shell 脚本结束时会被删除掉

#### **重新定向输入和输出**

bash shell 提供了几个操作符,可以将命令的输出重定向到另一个位置(比如文件). 重定向可以用于输入,也可以用于输出,可以将文件重定向到命令输入

**输出重定向**
`>` 符号用于输出到文件,但是会覆盖之前重新定向的内容; `>>` 符号会追加数据
**输入重定向**
输入重定向将文件的内容重定向到命令,或是说,对文件的内容进行命令处理
`内联输入重定向(inline input redirection)` 不需使用文件进行重定向,在命令行中指定用于输入重定向的数据就可以了,使用 `<<` 作为符号,`EOF` 为开始结束标记
**管道**
`|` 将一个命令的输出作为另一个命令的输入

#### **结构化命令**

对逻辑流程控制,改变程序的执行顺序,一般是`if then` 或者是`case`

**if-then**
shell 语法规定 if 后的命令会执行,如果状态码是`0`(成功),then 部分就会执行,fi 代表语句结束

`(())`命令允许你在比较过程中使用高级数学表达式
`[[]]`命令提供了针对字符串比较的高级特性
`case`命令将指定的变量与不同模式进行比较. 如果变量和模式是匹配的,那么 shell 会执行
为该模式指定的命令. 可以通过竖线操作符在一行中分隔出多个模式模式. 星号会捕获所有与已
知模式不匹配的值(swith 类似)

**for 命令**
for 、 while 和 until 迭代命令.大部分使用 for 或 while

从变量读取值时,可以结合命令获取的值赋予变量,然后循环,用`$()`包住命令或是用变量赋予

**字段分隔符**
是个坑,IFS ,叫作内部字段分隔符(internal field separator).
IFS 环境变量定义了 bash shell 用作字段分隔符的一系列字符. 默认情况下,bash shell 会将下列字
符当作字段分隔符:

-   空格
-   制表符
-   换行符

如果 bash shell 在数据中看到了这些字符中的任意一个,它就会假定这表明了列表中一个新数
据字段的开始. 在处理可能含有空格的数据(比如文件名)时,这会非常麻烦,就像你在上一个
脚本示例中看到的.

假定你要遍历一个文件中用冒号分隔的值(比如在
/etc/passwd 文件中)
. 你要做的就是将 IFS 的值设为冒号.
IFS=:
如果要指定多个 IFS 字符,只要将它们在赋值行串起来就行.
IFS=\$'\n':;"
这个赋值会将换行符、冒号、分号和双引号作为字段分隔符. 如何使用 IFS 字符解析数据没
有任何限制.

## 构造函数&原型对象

> 原型是一个对象，任何一个对象都可以成为原型，并让其他对象继承

### constructor **_属性_**

属性始终指向创建当前对象的构造函数

```js
var arr = [1, 2, 3];
console.log(arr.constructor); //输出 function Array(){}
var a = {};
console.log(arr.constructor); //输出 function Object(){}
var bool = false;
console.log(bool.constructor); //输出 function Boolean(){}
var name = 'hello';
console.log(name.constructor); //输出 function String(){}
var sayName = function () {};
console.log(sayName.constrctor); // 输出 function Function(){}

//接下来通过构造函数创建instance
function A() {}
var a = new A();
console.log(a.constructor); //输出 function A(){}
```

### prototype **_属性_**

prototype 属性是每个`函数对象`(**`function`**) 都有的属性，被称为**原型对象**，`_proto_` 属性是每个对象都有的属性，是指向该原型对象的内部指针.

prototype 属性指向被 构造函数 创建的 函数(**`function`**) 的原型对象

一旦原型对象被赋予了属性和方法，那么相应的构造函数创建的实例也会继承`prototype`上的属性和方法

### ES6 class

-   类(`Class`)的内部所有定义的方法，都是不可枚举的（但是在 es5 中 prototype 的方法是可以进行枚举的）
-   类(`Class`)的构造函数，不使用 new 是没法调用的，除了静态方法
-   类(`Class`)不存在变量提升（hoist）
-   ES5 的继承，实质是先创造子类的实例对象`this`，然后再将父类的方法添加到`this`上面`Parent.apply(this)`.ES6 的继承机制完全不同，实质是先创造父类的实例对象`this`（所以必须先调用 **`super`** 方法），然后再用子类的构造函数修改`this`

    ```js
    class Point {
        constructor(x, y) {
            this.x = x;
            this.y = y;
        }
        toString() {
            returu`(${this.x},${this.y})`;
        }
    }
    ```

-   类的所有方法都定义在类的 prototype 属性上，在类的实例上调用方法，就是调用原型上的方法

### 变量值类型

javascript 变量是松散类型变量,意味着可以给变量赋值任意类型,可以分为 `基本类型` `引用类型` 两类

-   `基本类型 :`包括 Undefined, Null, Boolean, Number 和 String 五种基本数据类型
    当复制基本类型的值时会在变量对象上创建一个新值,然后把该值复制到为新变量分配的位置上,两个变量互相操作而不受影响

    ```js
    let num1 = 5;
    let num2 = num1;
    num2++;
    console.log(num1, num2);
    ```

-   `引用类型 :`保存在内存中的对象们，不能直接操作，只能通过保存在变量中的地址引用对其进行操作
    当一个变量向另一个变量中赋值引用类型的值时,同样会吧存储在变量对象中的值复制一份到新变量,但是这个值只是一个指针,而这个指针指向的是存储在堆中的一个对象.复制结束之后,两个变量实际上引用一个对象,因此改变一个变量,就会影响另一个变量

    ```js
    tableBodys.splice(
        tableBody.findIndex(value => {
            return value[0].key == 'oneTask';
        }) + 1,
        4
    );
    tableBodys.splice(
        tableBody.findIndex(value => {
            return value[0].key == 'twoTask';
        }) + 1,
        5
    );
    var a = { name: 'apple' };
    var b = a;
    a.name = 'banana';
    b.name;
    ```

-   `解决方法 :` 因为传参的方法还是没有改变变量类型,所以妥善的做法是遍历这个对象(或数组)的值,重新复制一个

    ```js
    let arr = [1, 2, 3];
    let newarr = arr.slice(0);

    function clone(obj) {
        var o;
        if (typeof obj == 'object') {
            if (obj === null) {
                o = null;
            } else {
                if (obj instanceof Array) {
                    o = [];
                    for (var i = 0, len = obj.length; i < len; i++) {
                        o.push(clone(obj[i]));
                    }
                } else {
                    o = {};
                    for (var j in obj) {
                        o[j] = clone(obj[j]);
                    }
                }
            }
        } else {
            o = obj;
        }
        return o;
    }
    ```

## React 渲染&优化

在 React16 版本之后,生命周期更新了静态方法[getDerivedStateFromProps](https://zh-hans.reactjs.org/docs/react-component.html#static-getderivedstatefromprops),主要是解决异步渲染问题,分为`比较阶段`和`更新阶段`.

由于 React 在更新节点时,如果父节点改变,子节点也会相应改变(diff 算法),所以标识子节点使得组件在比较时更快找出改变的节点,加入 Key 可以使这一过程更容易.所以性能优化上,主要集中在一下几点:

-   避免没有必要的卸载和更新
-   保持标签和 DOM 结构的稳定性
-   避免重复渲染,可以使用`shouldComponentUpdate`生命周期来对比有无变化的`props`和`state`来避免组件更新,对于基本类型和引用类型的不同所带来的`shouldComponentUpdate`周期无效的情况,可以看一下[immutable](https://immutable-js.github.io/immutable-js/)的使用.
-   分离组件,尽量避免父组件的更新.
    比如,一个父组件里有循环出来的子组件,在更新 state 改变子组件数量或者值的时候,可以把改变的过程放在子组件完成或者是在父组件时将改变后的数据赋值给一个变量传入子组件中

[文章](https://www.my-fe.pub/post/front-end-performance-optimization-notes.html)
video：[从 React 渲染原理看性能优化@黄琼\_React CN 2018](https://www.youtube.com/watch?v=Go3BseQ1VZQ)

## Meteor

在 Ubuntu 或是 Win 环境安装时,按照[官网](https://www.meteor.com/install)操作即可.
注意 win 环境配置时,先安装[Chocolatey](https://chocolatey.org/install),然后根据`meteor npm i`,提示报错,安装`node-gyp`(应该是这个,具体看报错,全局安装),然后,配置环境变量

```shell
  #先查看meteor路径
  where.exe meteor
  #C:\Users\用户\AppData\Local\.meteor\meteor.bat
```

然后去 path 配置变量,最后启动 meteor

### RocketChat [API](https://rocket.chat/docs/developer-guides/rest-api/)

一个开源、开放、功能强大、基于 Meteor 和 MongoDB 的 Slack 替代软件....(~~聊天的~~)
在初始安装包时(`npm i`),可以尝试`meteor npm i` 命令安装

### 目录结构

-   `/client` 文件夹中所有文件都只发送到客户端.用来放置 HTML，CSS 和 UI 相关的 javascript 代码
-   `/server` 文件夹中所有文件都只提供给服务端使用，不会发送到客户端.用来放置不应该被客户端看到的敏感逻辑和数据
-   `/public` 文件夹中的文件会原样发送到客户端.用来放置资源

### [meteor 路由](http://www.sitexa.net/post/meteor-url-route/)

-   `triggers()` 路由触发时,最先调用这个方法,然后是`subscriptions`,最后是`action()`
-   `action()`路由匹配时触发,[详情](https://guide.meteor.com/routing.html#rendering-routes)

    ```js
    FlowRouter.route('/lists/:_id', {
        name: 'Lists.show',
        action() {
            BlazeLayout.render('App_body', { main: 'Lists_show_page' });
        },
    });
    //访问“/lists/:_id(自定义)下，“App_body”组件下main属性
    ```

-   `FlowRouter.subsReady()` 订阅管理,可以使用 FlowRouter.subsReady 在 template helpers 内部显示加载状态和相应的行为

    ```js
    Template.myTemplate.events({
        'click #id': function () {
            FlowRouter.subsReady('myPost', function () {
                // do something
            });
        },
    });
    ```

### [meteor 模板](https://segmentfault.com/a/1190000003781596),[解释](https://segmentfault.com/a/1190000003781596)

-   `Template.组件名.helpers` 给模板变量赋值,定义模板的 helpers
-   `{{title}}` 嵌入数据 ,调用属性或者方法
-   `{{#each data}}...{{/each}} {{#if data}}...{{/if}}` 控制结构
-   `Template.registerHelper` 定义所有模板都能用的 helper

    ```js
    Template.registerHelper('log', () => {
        console.log.apply(console, arguments);
    });
    Template.registerHelper('not', value => {
        return !value;
    });
    Template.registerHelper('hasPermission', function (permission, scope) {
        return hasPermission(permission, scope, atLeastOne);
    });
    ```

-   `unless/else模板标签` [模板逻辑控制,条件](http://www.hangge.com/blog/cache/detail_1340.html)；判断数据是不是 `false`（或者是 `"undefined"` 或 `"null"` 或`""` 或`"0"`. 是 `false` 的话则走 `{{#unless}}`，否则走 `{{else}}` 分支

    ```js
      //数据
      {
        name: 'John Doe',
        hobby: false
       }
      //样例
      <p>Hello, my name is {{name}}.</p>
      {{#unless hobby}}
      <p>I have hobby</p>
      {{else}}
      <p>I don't have hobby'</p>
      {{/unless}}
      //输出
      <p>Hello, my name is John Doe.</p>
      <p>I have hobby</p>
    ```

-   `{{> demo}}` 导入指定的模板

    ```js
      //admin
      <body>
        <h1>Hello!</h1>
        {{> xiongdihui}}
      </body>
      //zi
      <template name="xiongdihui">
        <p>Welcome to 兄弟会!</p>
      </template>
    ```

-   `Template.myTemplate.events(eventMap)` 模板事件.传给`Template.myTemplate.events`的事件`map`,用事件描述符作为`key`,事件处理函数作为`value`.事件处理函数接收两个参数：`事件对象和模板实例`

    ```js
    //例子
    Template._autocompleteContainer.events({
        'click .-autocomplete-item, click [data-autocomplete]'(e, t) {
            t.data.onItemClick(this, e);
        },
        'mouseenter .-autocomplete-item'(e, t) {
            t.data.onItemHover(this, e);
        },
    });
    //key前半部分是事件名称,后半部分是css选择器
    //无论何时，选定元素上触发了监听的事件时，对应的事件处理函数就会被调用
    //参数为：DOM事件对象(Events)和模板实例(Template)
    ```

-   `Template.registerHelper()` (原版调用为: Blaze.registerHelper()) ,用于注册全局 [helpers](http://blazejs.org/guide/reusing-code.html#Global-Helpers)

    ```js
    Blaze.registerHelper('pathFor', function (path, kw) {
        return FlowRouter.path(path, kw.hash);
    });
    ```

-   `Template instances` 获取模板实例,还可给模板实例附加属性,属性在模板响应式更新中保持,不会丢失
    -   在 created, rendered 和 destroyed 模板回调中，`this`指向模板实例
    -   事件处理器的第二个参数
    -   在 Helper 中,通过`Template.instance()` 获取
    ```js
    Template.appInstall.helpers({
        isInstalling() {
            return Template.instance().isInstalling.get();
        },
        appUrl() {
            return Template.instance().appUrl.get();
        },
    });
    ```
-   `Template.myTemplate.onCreated()` 模板初始时调用方法,设定初始值,参数是要执行的方法

    ```js
    Template.readReceipts.onCreated(function readReceiptsOnCreated() {
        this.loading = new ReactiveVar(false);
        this.readReceipts = new ReactiveVar([]);
    });
    //初始化值
    Template.hello.onCreated(function () {
        console.log('产生模板..');
        this.timer = null;
        this.number = 0;
    });
    ```

-   `Template.myTemplate.onRendered` 模板被插入 DOM 时调用的方法,相似于`ReactDOM.render()`

    ```js
    Template.readReceipts.onRendered(function readReceiptsOnRendered() {
        this.loading.set(true);
        Meteor.call(
            'getReadReceipts',
            {
                messageId: this.data.messageId,
            },
            (error, result) => {
                if (!error) {
                    this.readReceipts.set(result);
                }
                this.loading.set(false);
            }
        );
    });
    ```

    当前阶段可操作 DOM 元素,可以通过`find()`查找,参数是`css选择器`查找,或者`findall()`查询所有符合的元素,或使用`$()` 注意 JQ 选择下对象是 JQdom 对象,只能在此过程调用

-   `Template.myTemplate.onDestroyed()` 模板被销毁时调用

    ```js
    Template.hello.onDestroyed(function () {
        console.log('摧毀模板..');
        // 清除 timer
        clearInterval(this.timer);
    });
    //OR 执行一些操作
    Template.rc_modal.onDestroyed(function () {
        document.removeEventListener('keydown', modal.onKeydown);
    });
    Template.popover.onDestroyed(function () {
        if (this.data.onDestroyed) {
            this.data.onDestroyed();
        }
        $(window).off('resize', this.position);
    });
    ```

-   [函数反应式编程](http://cw.hubwiz.com/card/c/55b87a7b3ad79a1b05dcc339/1/3/2/) `ReactiveVar` 类创建反应式数据(变量),触发变量既有响应式结果

    -   创建 `new ReactiveVar(初始值 ('字符串';10) )`
    -   `set() get()` 获取或设置值

        ```js
        const number = this.number.get();
        this.number.set(number + 1);
        ```

    -   多数用在模板的

        ```js
        Template.appLogs.onCreated(function () {
            const instance = this;
            this.id = new ReactiveVar(FlowRouter.getParam('appId'));
            this.ready = new ReactiveVar(false);
            this.hasError = new ReactiveVar(false);
            this.theError = new ReactiveVar('');
            this.app = new ReactiveVar({});
            this.logs = new ReactiveVar([]);

            const id = this.id.get();
            Promise.all([RocketChat.API.get(`apps/${id}`), RocketChat.API.get(`apps/${id}/logs`)])
                .then(results => {
                    instance.app.set(results[0].app);
                    instance.logs.set(results[1].logs);

                    this.ready.set(true);
                })
                .catch(e => {
                    instance.hasError.set(true);
                    instance.theError.set(e.message);
                });
        });
        ```

-   [Blaze API](http://blazejs.org/api/blaze.html)
    Blaze 是 Meteor 預設的前端框架,整合了 Meteor 的 Tracker 和 Minimongo，能夠隨著資料變動而自動更新使用者畫面，因此開發者不需要決定什麼時候去更新網頁元素，也不需要做 data-binding,常用:
    -   `Blaze.render（templateOrView，parentNode，[nextNode]，[parentView]）`
        将模板渲染到指定节点 ,`templateOrView` 为模板或 view 对象, `parentNode` 为呈现模板的父节点,必须是 Element 节点
    -   `Blaze.renderWithData（templateOrView，data，parentNode，[nextNode]，[parentView]）`
        将数据和模板绑定,插入到节点. `data`为数据,若无此参数,和`render`基本相同
    -   `Blaze.remove（renderedView）` 从 DOM 中删除节点,然后停止跟踪和更新节点
        ```js
        var myData3 = Blaze.render(myData, myData2);
        // 3s后删除数据
        Meteor.setTimeout(() => {
            Blaze.remove(myData3);
        }, 3000);
        //OR
        Blaze.remove(Blaze.getView(document.getElementsByClassName('Test')[0]));
        ```
    -   `Blaze.getData（[elementOrView]）` 返回当前数据,`elementOrView` 为渲染的元素
    -   `Blaze.toHTMLWithData（templateOrView，data）` 将模板渲染成 HTML,`templateOrView` 为用于生成 HTML 的模板,`data`为关联数据

### [Collection 数据集合](https://wizardforcel.gitbooks.io/meteor-doc/content/12.html)

Meteor 用集合保存数据.集合里保存的 Javascript 对象叫做文档.使用`new Mongo.Collection`声明一个集合,[Mongo 运算符详情](https://docs.mongodb.com/manual/reference/operator/query/)

```js
  //创建
  var msgs = new Mongo.Collection("messages");
  //CRUD
  msgs.insert(...);
  msgs.update(...);
  msgs.remove(...);
  msgs.find(...);
```

默认情况下,前端后端的同名数据集自动保持同步,在前端插入的数据，会通过 Meteor 的 RPC 机制插入到后端数据集，而后端数据的变化， 将通过 pub/sub 机制自动传播到前端,[例子](http://cw.hubwiz.com/card/c/55b87a7b3ad79a1b05dcc339/1/5/1/#-collection)

```js
//前后端创建同名Collection对象
var msgs = new Mongo.Collection('messages');
if (Meteor.isServer) {
    //后端发布
    Meteor.publish('ezpub', function () {
        return msgs.find();
    });
}
if (Meteor.isClient) {
    //前端订阅
    Meteor.subscribe('ezpub');
}
```

-   每个`Mongo.Collection`里的每个文档都有一个`_id`字段.它必须是唯一的，如果你没有提供，会自动生成,
    `collection.findOne`使用`_id`可以用来检索特定的文档

-   `insert(doc,[callback])` 集合对象的`insert()` 方法,向集合插入一天数据(`JSON对象`).`doc`指作为数据的对象,`callback()` 指插入数据完成之后的回调

    ```js
      const Todos = new Mongo.Collection();
      ...
      Template.hello.events({
        'keyup #myInput'(event, templateInstance) {
          if (event.keyCode === 13) {
            Todos.insert({
              text: event.currentTarget.value,
              date: new Date(),
            });
            event.currentTarget.value = '';
          }
        }
      });
    ```

-   `find([selector],[options])` 查找集合中满足指定条件的文档 . `selector` 指定文档选择符,如果为`{}`,则查询集合下的所有. `options` 指筛选条件,JOSN 格式: 返回数目,排序顺序... , [详情](https://wizardforcel.gitbooks.io/meteor-doc/content/12.html#options)

    ```js
    var demo = new Mongo.Collection('persons');
    //对返回结果按 age 字段排序
    var cursor = demo.find({}, { sort: { age: 1 } });
    //跳过指定数量文档:年龄大于20,并跳过100个文档返回剩余的
    var cursor = demo.find({ age: { $gt: 20 } }, { skip: 100 });
    //限定返回文档数量,分页:年龄大于20,并返回最多10个文档
    var cursor = demo.find({ age: { $gt: 20 } }, { limit: 10 });
    //对所有返回结果限定:返回每个文档中的namge.tel字段
    var cursor = demo.find({}, { fields: { name: 1, tel: 1 } });
    ```

    `find()`查询出来的结果是一个`游标/Cursor`对象,只是记录数据库地址,查询条件,查询选项,没有物理的访问数据库,真正获取数据,需要使用游标对象方法

    -   `Cursor.forEach(callback,[thisArg])`对游标匹配的文档集中的每一个文档执行 callback 参数指定的处理函数

        ```js
        demo.find({ name: 'Jason' }).forEach(function (doc) {
            console.log(doc.tel);
        });
        ```

    -   `Cursor.map(callback,[thisArg])` 匹配每一个文档对象,通过 callback 参数指定的 映射函数 返回一个新值
        ```js
        var tels = demo.find({ name: 'Jason' }).map(function (doc) {
            return doc.tel;
        });
        ```
    -   `Cursor.fetch()` 提取游标匹配的所有文档,返回这些文档组成的数组
        ```js
        var demo = new Mongo.Collection('persons');
        var persons = demo.find().fetch();
        ```
    -   `Cursor.count()` 返回游标匹配的文档数量

    <br>

-   `update(selector, modifier, [options], [callback])` 更新集合中指定文档.
    `selector` 指文档选择符,文档\_id 或者是合法的 MongoDB 选择器.`modifier` 指文档修改指令对象,根据这个指令修改匹配的数据.`options` 可选,JSON 对象,`callback` 完成之后的回调,在后端调用该方法时，如果不指定`callback`参数，将阻塞执行直至更新完成，或者在发生 错误时抛出异常；前端不支持同步阻塞方式的执行，因此如果不设置`callback`参数，将 无法捕捉错误和执行结果

    ```js
      var demp = new Mongo.Collection("persons");
      //options 参数:multi 为true时更新匹配选择条件的所有文档:修改所有name为jason的分值为100
      demo.update({name:"Jason"},{$set:{score:100},{multi:true}})
      //options 参数:upsert 若果为true,在无法找到匹配文档时,执行插入操作:修改name为jason的第一条数据,如果找不到,插入name,tel数据
      demo.update({name:"Jason"},{name:"Jason",tel:"114"},{upsert:true});
    ```

    `update()`方法的行为取决于是在受信代码中被调用，还是在非受信代码中被调用.服务端 代码被认为是受信代码，而浏览器中运行的客户端代码被认为是非受信代码.

    在受信代码中，可以设置`options`参数的`multi`属性来一次更新多个文档，然而在非受信 代码中，只可以是使用文档的`_id`作为选择符，一次更新一个文档，而且还必须通过应用层 设置的`allow`和`deny`规则检查.此外，非受信代码中调用的`update()`方法，也不能执行通过 设置`options`参数的`upsert`属性来执行无匹配时的插入操作 —— 除非在应用中添加了`insecure`包(`meteor add insecure`)

-   `remove(selector,[callback])` 删除指定文档.`selector` 指文档选择符,为文档 ID 或合法的 MongoDB 选择符,`callback()` 更新完后的回调

    ```js
    var demo = new Mongo.Collection('persons');
    demo.remove({ name: 'Jason' });
    ```

    `remove()`方法的行为取决于是在受信代码中被调用，还是在非受信代码中被调用. `服务端`代码被认为是受信代码，而浏览器中运行的`客户端`代码被认为是非受信代码.

    在受信代码中，可以使用`任意MongoDB的选择符`实现一次删除`多个`文档，然而在非受信代码中，只能使用文档的`_id`作为选择符，一次删除`一个`文档，而且还必须通过应用层 设置的`allow`和`deny`规则检查.

-   [Meteor.wrapAsync(func, [context])](https://docs.meteor.com/api/core.html#Meteor-wrapAsync) : 在服务端执行,将异步函数封装成同步函数.封装后的函数在服务端既可以作为异步函数(传入回调函数)也可以作为同步函数使用(不传入回调函数). 在客户端(浏览器端)还是需要传入回调函数作为异步函数使用,注意在异步函数中需要有回调函数,否则会堵塞,[详情](https://www.cnblogs.com/meteorcn/p/MeteorJS_Async_Fiber_Future_Wrap.html)

### [Methods RPC 协议实现方法](http://cw.hubwiz.com/card/c/55b87a7b3ad79a1b05dcc339/1/2/2/)

**Methods**是客户端调用服务端的方法

`Meteor.methods(methods)` 定义方法操作数据库,避免客户端直接呼叫`insert`,`update`, `remove`等方法,用`Meteor.call(name,[arg1,arg2],[asyncCallback])` 方法调用,[参数详情](https://docs.meteor.com/api/methods.html#Meteor-call).

```js
  //server side
  Meteor.methods({
    'calcSalary':function(name){
      //喜欢的三个员工给多点
      if(name==='Mary') return 100000.00；
      if(name==='Linda') return 50000.00;
      if(name==='Tommy') return 78000.00;
      //其他员工都给一样的薪酬
      return 15000.00;
    }
  });
  //client side
  //异步调用，调用结果或错误将被传入回调函数
  Meteor.call("calcSalary","Mary",function(error,result){
    $("body").html("result is " + result);
  });
```

### [Meteor Package](https://docs.meteor.com/api/packagejs.html)

`Package`是一个包含`package.js`文件的目录，该文件大致包含三个主要部分：基本描述，包定义和测试定义. 默认情况下，目录名称是包的名称

```js
// Information about this package:
Package.describe({
    // Short two-sentence summary
    summary: 'What this does',
    // Version number
    version: '1.0.0',
    // Optional, default is package directory name
    name: 'username:package-name',
    // Optional GitHub URL to your source repository
    git: 'https://github.com/something/something.git',
});

// This defines your actual package:
Package.onUse(api => {
    // If no version is specified for an `api.use` dependency, use the one defined
    // in Meteor 1.4.3.1.
    api.versionsFrom('1.4.3.1');
    // Use the `underscore` package, but only on the server. Version not
    // specified, so it will be as of Meteor 1.4.3.1.
    api.use('underscore', 'server');
    // Use `kadira:flow-router`, version 2.12.1 or newer.
    api.use('kadira:flow-router@2.12.1');
    // Give users of this package access to active-route's JavaScript helpers.
    api.imply('zimme:active-route@2.3.2');
    // Export the object `Email` to packages or apps that use this package.
    api.export('Email', 'server');
    // Specify the source code for the package.
    api.addFiles('email.js', 'server');
    // When using `ecmascript` or `modules` packages, you can use this instead of
    // `api.export` and `api.addFiles`.
    api.mainModule('email.js', 'server');
});

// This defines the tests for the package:
Package.onTest(api => {
    // Sets up a dependency on this package.
    api.use('username:package-name');
    // Use the Mocha test framework.
    api.use('practicalmeteor:mocha@2.4.5_2');
    // Specify the source code for the package tests.
    api.addFiles('email_tests.js', 'server');
});

// This lets you use npm packages in your package:
Npm.depends({
    simplesmtp: '0.3.10',
    'stream-buffers': '0.2.5',
});
```

`Package.onUse（FUNC）` 定义包依赖关系,和公开包的方法

-   `api.use（packageNames，[architecture]，[options]）`
    **packageName** 指包依赖于,可指定版本号,例:`'accounts@1.0.0'`
    **architecture** 指定包在什么体系结构使用,`server` or `client`
-   `api.export（exportedObjects，[architecture]，[exportOptions]，exportOptions.testOnly）`
    导出包中的变量
-   `api.addFiles(filenames, [architecture], [options])`
    指定包的源文件. **filenames** 指源文件路径,**architecture** 指定运行在哪个体系结构

## Nginx & certbot & Jitsi Meet

### [HTTP 和反向代理服务器](http://www.runoob.com/linux/nginx-install-setup.html)

-   [安装](https://www.cnblogs.com/languoliang/archive/2013/04/01/nginx.html)
    > sudo apt install nginx
    > 启动 sudo service nginx restart
    > worker_processes: 每个 worker 进程的最大连接数
-   注意: 如果报错,检查`/etc/nginx/sites-available` 目录下的配置文件,或运行`nginx -t` 检查配置文件语法,根据内容提示行检查

    ```config
      # Default server configuration
      #
      #
      upstream backend {
              server 127.0.0.1:3000;
      }

      server {
        listen 80;
        listen [::]:80;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name dling.org;

        location / {
          # First attempt to serve request as file, then
          # as directory, then fall back to displaying a 404.
          # try_files $uri $uri/ =404;
          proxy_pass http://192.168.10.206:3000/;
        }

        # pass PHP scripts to FastCGI server
        #
        #location ~ \.php$ {
        #	include snippets/fastcgi-php.conf;
        #
        #	# With php-fpm (or other unix sockets):
        #	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        #	# With php-cgi (or other tcp sockets):
        #	fastcgi_pass 127.0.0.1:9000;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #	deny all;
        #}
        }
        # Virtual Host configuration for example.com
        #
        # You can move that to a different file under sites-available/ and symlink that
        # to sites-enabled/ to enable it.
        #
        #server {
        #	listen 80;
        #	listen [::]:80;
        #
        #	server_name example.com;
        #
        #	root /var/www/example.com;
        #	index index.html;
        #
        #	location / {
        #		try_files $uri $uri/ =404;
        #	}
        #}

    ```

### [SSL 简化申请流程](https://caloskao.org/ubuntu-use-certbot-to-automatically-update-lets-encrypt-certificate-authority/)

-   [安装](https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx) 按照命令安装.注意选择 OS 和软件,在设置`certbot --nginx`时需要域名和邮箱
-   `sudo certbot renew --dry-run` 自动更新命令检测

### [Jitsi Meet 安装](https://github.com/jitsi/jitsi-meet/blob/master/doc/quick-install.md)

注意: 用`sudo su` 获取权限安装,设置域名问题,如果错误设置域名,运行一下[步骤](https://github.com/jitsi/jitsi-meet/issues/2663)

> 1 . apt-get --purge remove jitsi-meet jitsi-meet-prosody jitsi-meet-web jitsi-meet-web-config jicofo jitsi-videobridge
> 2 . apt-get autoclean
> 3 . apt-get --force-yes remove
> 4 . apt-get install --reinstall dpkg
> 5 . cd /var/lib/dpkg/info
> 6 . sudo rm jitsi-meet-web-config.postinst

## [Kubernetes](https://github.com/wh211212/awesome-kubernetes-cn) && [Docker](http://guide.daocloud.io/dcs/docker-9152673.html)

Kubernetes 是一个开源系统，用于自动化集装箱化应用程序的部署，扩展和管理.
Docker 是一种容器技术，它可以将应用和环境等进行打包，形成一个独立的，类似于 iOS 的 APP 形式的「应用」，这个应用可以直接被分发到任意一个支持 Docker 的环境中，通过简单的命令即可启动运行.
Docker 是一种最流行的容器化实现方案. 和虚拟化技术类似，它极大的方便了应用服务的部署；又与虚拟化技术不同，它以一种更轻量的方式实现了应用服务的打包.
使用 Docker 可以让每个应用彼此相互隔离，在同一台机器上同时运行多个应用，不过他们彼此之间共享同一个操作系统. Docker 的优势在于，它可以在更细的粒度上进行资源的管理，也比虚拟化技术更加节约资源.

### Kubernetes [中文文档](http://docs.kubernetes.org.cn/247.html) [模型文档](https://kubernetes.io/docs/reference/federation/v1/definitions/)

Kubernetes 集群包含一个 master 和多个 node;Master 是控制集群的中心，node 是提供 CPU、内存和存储资源的节点. Master 上运行着很多进程，包括面向用户的 API 服务、负责维护集群状态的 Controller Manager、负责调度任务的 Scheduler 等. 每个 node 上运行着维护 node 状态并和 master 通信的 kubelet，以及实现集群网络服务的 kube-proxy

-   `Service` [抽象定义](https://kubernetes.io/zh/docs/concepts/services-networking/service/),一个 Pod 的逻辑分组，一种可以访问它们的策略 —— 通常称为微服务. 这一组 Pod 能够被 Service 访问到，通常是通过 Label Selector（查看下面了解，为什么可能需要没有 selector 的 Service）实现的

### 安装示例&注意事项

#### 常用

-   [终端颜色](https://xmyunwei.com/1794.html),一片白很不爽...
-   VirtualBox 在安装 `centos 7` 时,默认无法访问外部,改一下[网卡设置](https://blog.csdn.net/fuguangruomeng/article/details/79244055)

    ```shell
      vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
      ONBOOT=yes
      service network restart
      yum install epel-release wget yum-utils -y
      yum update
    ```

-   [批量导入 xshell](https://blog.netsarang.com/91/importing-csv-formatted-host-information-to-xshell/),记得检查里面的逗号有没有分割,否则后报错,格式如下`PRD-svr75101,0.0.5.101,ssh,22,root,password`
-   `reboot` 重启,不要关机!!!
-   未找到命令,多半是没安装..yum 安装一下
-   命令

    ```shell
      # 查看节点状态
      kubectl get nodes
      kubectl get services --all-namespaces
      # 查看pods状态
      kubectl get pods --all-namespaces
      # 查看K8S集群状态
      kubectl get cs
      # 强制删除镜像
      docker rmi -f [options]
      # 重新生成 token
      kubeadm token create --print-join-command
      # 查看kubelet 日志
      journalctl -u kubelet -f
      # 确认master节点状态和etcd集群状态
      kubectl get componentstatus
      # 查看详细pod日志 通过kubectl get pod 获取名称
      kubectl logs -n kube-system kubernetes-dashboard-58ddfdfd68-nv884
      # ansible 安装 重置 命令
      ansible-playbook -u centos -b -i inventory/inventory.cfg cluster.yml -vvv
      ansible-playbook -i inventory/inventory.cfg reset.yml -b -vvv --private-key=~/.ssh/id_rsa
      # 查看 disable_ipv6_dns
      cat /roles/kubernetes/preinstall/defaults/main.yml | grep disable_ipv6_dns
      # 查看node节点出错任务 (一般是python进程)
      ps aux | grep python

    ```

#### 单节点

-   大坑!!! 配置镜像时,选择一个配置方式,1.12 以上是,如果配置 json 文件无用,选择以下方式配置
    [修改 docker.service](http://shouce.jb51.net/docker_practice/install/mirror.html),[修改 docker.service2](https://www.jianshu.com/p/42772740f09a)
    如果同时配置了 json 和 service 文件,会启动错误,按照这个[配置](https://www.imooc.com/article/264027),然后重启一下 docker

    ```shell
      systemctl daemon-reload
      systemctl restart docker
    ```

-   `docker代理` docker 的代理是独立于 centos 的，需要单独[配置](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy)
    **大坑!!!!!!!**---解决镜像源配置成功后,无法 pull 镜像或是登陆问题

    ```shell
      vim /etc/systemd/system/multi-user.target.wants/docker.service
      echo Environment='"HTTP_PROXY=http://你的代理/"' '"HTTPS_PROXY=http://你的代理(或者是有端口的)/"' >> /etc/systemd/system/multi-user.target.wants/docker.service
    ```

-   `下载k8s所需镜像` 通过 Docker 下载提示的版本,[.sh 下载](https://haojianxun.github.io/2018/10/14/%E4%BD%BF%E7%94%A8kubeadm%E4%BB%8E0%E5%BC%80%E5%A7%8B%E6%90%AD%E5%BB%BAkubernetesv1.11.1/),然后`init`初始化集群
    **注意**,初始化集群时,需要把提前拉下来的镜像改为`k8s.gcr.io/`开头,[方便识别](https://www.kubernetes.org.cn/3805.html#highlighter_534436)
    **特别注意,当初始化 init 提示你的所需下载名称,要与你用 shell 下载的镜像名称相同,一定要 TM 相同,比如提示没有-amdin64(后缀),就不要下载带后缀的,不识别!!!**

    记得修改主机名称: `hostnamectl set-hostname master1` , `cat /etc/hostname`

    ```shell
      #!/usr/bin/env bash

      docker pull coredns/coredns:1.2.6
      docker tag coredns/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6
      docker rmi coredns/coredns:1.2.6

      docker pull jmgao1983/flannel:v0.11.0-amd64
      docker tag jmgao1983/flannel:v0.11.0-amd64 k8s.gcr.io/flannel:v0.11.0-amd64
      docker rmi jmgao1983/flannel:v0.11.0-amd64

      images=(
          kube-apiserver:v1.13.4
          kube-controller-manager:v1.13.4
          kube-scheduler:v1.13.4
          kube-proxy:v1.13.4
          pause:3.1
          etcd:3.2.24
      )

      for imageName in ${images[@]}; do
          docker pull mirrorgooglecontainers/$imageName
          docker tag mirrorgooglecontainers/$imageName k8s.gcr.io/$imageName
          docker push mirrorgooglecontainers/$imageName
      done

      #quay.io/coreos/flannel:v0.7.0-amd64
      #docker tag quay.io/coreos/flannel:v0.7.0-amd64 f6j1klbv.mirror.aliyuncs.com/flannel:v0.7.0-amd64
      #docker push f6j1klbv.mirror.aliyuncs.com/flannel:v0.7.0-amd64

    ```

#### 多节点高可用

了解[Ansible](https://getansible.com/begin/an_zhuang_ansile),对多节点配置一般都是通过 Ansible 写配置然后一键生成,这里是他的[参数文档](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html?highlight=when)和[视频资料](https://www.bilibili.com/video/av25424954/).

以及,需要用到的项目--- [Kubespray](https://github.com/kubernetes-sigs/kubespray),如果网络不错(你懂),配置十分便捷,注意官方文档总结的[要求](https://github.com/kubernetes-sigs/kubespray#user-content-requirements),下面是几篇不错的安装指南

-   [使用 Kubespray 部署 kubernetes 高可用集群](https://blog.51cto.com/foxhound/2044766)
-   [快速部署 kubernetes 高可用集群](https://mritd.me/2017/03/03/set-up-kubernetes-ha-cluster-by-kargo/)
-   [kargo 集群扩展及细粒度配置](https://mritd.me/2017/03/10/kargo-cluster-expansion-and-fine-grained-configuration/)
-   [用 kargo 快速自动化搭建 kubernetes 集群](https://tech.cuixiangbin.com/?p=1112)
-   [[Kubernetes] 使用 kubespray 安装 k8s 集群](https://www.huweihuang.com/article/kubernetes/install-k8s-by-kubespray/#top)

下面是我遇到的错误(多半是网络错误,fu\*\*)

-   Docker 镜像问题 :
    对于这个 Kubespray 来说,单节点的修改镜像方法并不适用,需要修改它的配置文件,我用了一个愚蠢的办法,拉下来项目,然后[全局替换掉 docker 下载地址](http://mirror.azure.cn/help/docker-registry-proxy-cache.html)

    ```shell
    ...

    kube_image_repo: "gcr.io/google-containers"  -> kube_image_repo: "gcr.azk8s.cn/google-containers"

    ```

-   yum 源问题 :
    一般来讲阿里源已经够用了,注意的是要所有节点配置相同的 yum 源和 epel 源,然后统一生成缓存,[参考](https://my.oschina.net/dingzang/blog/702891)

-   一系列的网络问题 :
    集中在访问几个任务中 ,都是网络代理原因导致访问 ipv6 网络的请求失败例子

    | 任务                                      | 路径                                                         |
    | ----------------------------------------- | ------------------------------------------------------------ |
    | `Update package management cache (YUM)`   | `roles/kubernetes/preinstall/tasks/0070-system-packages.yml` |
    | `Check python-pip package`                | `roles/bootstrap-os/tasks/bootstrap-centos.yml`              |
    | `check if container-selinux is available` | `roles/container-engine/docker/tasks/main.yml`               |
    | `kubernetes image repo define`            | `roles/download/defaults/main.yml`                           |

    <small>_这里需要注意上一步的是修改 kus 的下载地址_ </small>

    通过 \$http_proxy 来获取你的代理地址,添加到访问出错的任务列表里

    在上述路径里,添加代理字段 `http_proxy`

    ```shell

    - name: Update package management cache (YUM)
      yum:
        update_cache: yes
        name: '*'
      environment:
        http_proxy: http://10.0.0.1:3333(例子)
      register: yum_task_result
      until: yum_task_result is succeeded
      retries: 4
      ...

    ```

    ```shell
      # Download URLs
      # kubeadm_download_url: "https://storage.googleapis.com/kubernetes-release/release/{{ kubeadm_version }}/bin/linux/{{ image_arch }}/kubeadm"
      kubeadm_download_url: "http://10.0.1.1/kubeadm"
      # hyperkube_download_url: "https://storage.googleapis.com/kubernetes-release/release/{{ kube_version }}/bin/linux/{{ image_arch }}/hyperkube"
      hyperkube_download_url: "http://10.0.1.1/hyperkube"
      # etcd_download_url: "https://github.com/coreos/etcd/releases/download/{{ etcd_version }}/etcd-{{ etcd_version }}-linux-{{ image_arch }}.tar.gz"
      etcd_download_url: "http://10.0.1.1/etcd-{{ etcd_version }}-linux-{{ image_arch }}.tar.gz"
      # cni_download_url: "https://github.com/containernetworking/plugins/releases/download/{{ cni_version }}/cni-plugins-{{ image_arch }}-{{ cni_version }}.tgz"
      cni_download_url: "http://10.0.1.1/cni-plugins-{{ image_arch }}-{{ cni_version }}.tgz"

    ```

-   在配置成功后 ,添加 node 节点成功但是显示 `NotReady` :
    网络插件问题,可以查看 node 节点信息看到 `kubectl describe node [nodename]`
    [修改方式](https://github.com/kubernetes/kubeadm/issues/1031)就是,下载`kube-flannel.yml` 文件

    ```shell
      kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

      # 重启
      reboot

      kubecli get nodes
    ```

-   `FAILED! => {"msg": "Timeout (12s) waiting for privilege escalation prompt: "}` 问题, 多半发生在重置集群后,因为[权限问题](https://github.com/ansible/ansible/issues/33699),解决办法,制定 ansbile `-T` 命令,一般是 300 , `ansbile ... -T 300`

-   [Dashboard 查看](https://godleon.github.io/blog/Kubernetes/k8s-Deploy-and-Access-Dashboard/) ,注意这篇文章 sh 命令,是换行

-   查看错误,多半在项目的 lssues 中,可以搜索关键字来确认,这是一些错误集锦 :
    [https://github.com/kubernetes/kubeadm/issues/1031](https://github.com/kubernetes/kubeadm/issues/1031)
    [https://github.com/kubernetes/kubernetes/issues/67057](https://github.com/kubernetes/kubernetes/issues/67057)
    [https://github.com/kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray)
    [https://github.com/kubernetes-sigs/kubespray/issues/2517](https://github.com/kubernetes-sigs/kubespray/issues/2517)
    [https://github.com/kubernetes/kubernetes/issues/72680](https://github.com/kubernetes/kubernetes/issues/72680)
    [https://github.com/kubernetes/kubeadm/issues/1031](https://github.com/kubernetes/kubeadm/issues/1031)
    ...(太多忘了存)

还有一些常用的 sh 命令,在另一个文件里

## Redis

Redis 是非关系型数据库(NoSQL),使用内存存储,并能存储 5 种不同数据结构类型之间的映射，分别是`STRING(字符串)`、`LIST(列表)`、`SET(集合)`、`HASH(散列)`、`ZSET(有序集合)`

[分布式锁的目的](https://www.cnblogs.com/rjzheng/p/9310976.html),保证同一时间只有一个客户端可以对共享资源进行操作

### 安装(Ubuntu18.0.4)

> sudo spt install redis-server 直接安装
> redis-cli 测试,然后执行 PING 命令验证
> exit 执行退出

[在线运行 Redis 网站](http://try.redis.io/),尝试命令;[Redlock:node 下的分布式锁](http://ifeve.com/redis-lock/)

### 命令(String 类型)

-   `SET key value [EX seconds] [PX milliseconds] [NX|XX]` 共有五个参数,`空格分割`.
    `EX second` 代表设置键的过期时间为 `second` 秒(???wtf)
    `PX millisecond` 代表设置键的过期时间为 `millisecond` 毫秒
    `NX` 只在键不存在时，才对键进行设置操作
    `XX` 只在键已经存在时，才对键进行设置操作

    ```js
      //PX 选项
      redis <127.0.0.1:6379> SET key-with-pexpire-time "moto" PX 123321
      OK

      redis <127.0.0.1:6379> GET key-with-pexpire-time
      "moto"

      redis <127.0.0.1:6379> PTTL key-with-pexpire-time
      (integer) 111939
      //NX 选项
      redis <127.0.0.1:6379> SET not-exists-key "value" NX
      OK      # 键不存在，设置成功

      redis <127.0.0.1:6379> GET not-exists-key
      "value"

      redis <127.0.0.1:6379> SET not-exists-key "new-value" NX
      (nil)   # 键已经存在，设置失败

      redis <127.0.0.1:6379> GEt not-exists-key
      "value" # 维持原值不变
      //XX 选项
      redis <127.0.0.1:6379> EXISTS exists-key
      (integer) 0

      redis <127.0.0.1:6379> SET exists-key "value" XX
      (nil)   # 因为键不存在，设置失败

      redis <127.0.0.1:6379> SET exists-key "value"
      OK      # 先给键设置一个值

      redis <127.0.0.1:6379> SET exists-key "new-value" XX
      OK      # 设置新值成功

      redis <127.0.0.1:6379> GET exists-key
      "new-value"
    ```

## MYSQL

MySQL 为关系型数据库(Relational Database Management System)，一个关系型数据库由一个或数个表格组成

> 数据仓库 注重决策,复杂的分析操作; 数据库 基本的、日常的事务处理,使用原始格式保存大量原始数据

-   `表头(header)`: 每一列的名称
-   `列(col)`: 具有相同数据类型的数据的集合
-   `行(row)`: 每一行用来描述某个人/物的具体信息
-   `值(value)`: 行的具体信息, 每个值必须与该列的数据类型相同
-   `键(key)`: 表中用来识别某个特定的人物的方法, 键的值在当前列中具有唯一性

## Java

### 关键字

`public`、`class`和`static`等单词都是 Java 语言中的关键字,`public`称为`访问修饰符`,用于控制程序的其他部分对这段代码的访问级别.
关键字也称之为保留字

### 识别符

Java 程序的各个组成部分都需要名字.类名、变量名、方法名、方法参数名等都被称为标识符.比如`HelloWorld`这个类名在代码中就是一种标识符.标识符是我们自己来命名的.

-   所有的标识符都应该以`字母（A-Z或者a-z）`,`美元符（$）`、或者`下划线（_）`开始
-   首字符之后可以是字母`（A-Z或者a-z）`,`美元符（$）`、`下划线（_）`和数字的组合
-   Java 语言自带的关键字不能用作标识符，比如你不能定义一个类或者方法命名为`class`
-   `标识符是大小写敏感的`

### 数据类型&变量

`变量（Variable）`是在内存中动态存储值的地方.简单地理解，程序的作用就是对变量进行各种运算
Java 是一种强类型语言.Java 要求在使用一个变量前要求必须声明它的类型.分为:

-   `基本数据类型（或者称为原生数据类型）`
-   `引用数据类型`

#### 声明变量

声明一个变量之后, 必须用赋值语句对变量进行显式初始化, 千万不要使用未初始化的
变量

```java
public class VariableTest {
    public static void main(String[] args) {
        int a = 1, b, c = 2;
        double pi = 3.14159;
        char x = 'x';
    }
}
```

**常量** 在 Java 中, 利用关键字 `final` 指示常量

```java
public class Constants
{
  public static void main ( String [] args)
  {
    final double CM _ PER INCH = 2.54 ;
    double paperWidth = 8.5;
    double paperHeight = 11;
    System.outprintln( " Paper size in centimeters : "
    + paperWidth * CM PER INCH + " by " + paperHeight;
  }
  * CM.PER.INCH ) ;
}
```

关键字 final 表示这个变量只能被赋值一次 . 一旦被赋值之后, 就不能够再更改了 . 习惯上 ,
常量名使用全大写

#### 基本数据类型

Java 语言提供了八种基本类型，其中包括六种数字类型（四种整数型，两种浮点型），一种字符类型，还有一种布尔型

[基本类型示例](https://course.tianmaying.com/java-basic+data-types#2)

#### 数组

一系列相同类型的数据. 一个数组一旦创建后，它的长度是固定的.通过一个整型下标可以访问数组中
的每一个值

-   一旦创建了数组, 就不能再改变它的`大小`
-   `for each` 循环

    ```java
      for (int element : a )
      System.out.println (element ) :
    ```

-   初始化及匿名数组 :`int [] small Primes = { 2 , 3 , 5 , 7 , 11 , 13 } ;`

#### 字符串

从概念上讲, Java 字符串就是 `Unicode` 字符序列 ,`String`并不是基本的数据类型，是一个类

-   `String str = "abc"` 最常见的定义字符串实例

-   可以通过`+` `+=` 操作字符串拼接

    ```java
    String expletive = " Expletive" ;
    String PC13 = " deleted " ;
    String message = expletive + PC13;
    ```

-   当将一个字符串与一个非字符串的值进行拼接时 , 后者被转换成字符串 ,任何一个 Java 对象都可以转换成字符串

    ```java
      int age= 13;
      String rating = " PC " + age
      //rating 为13
    ```

-   `substring()` 方法 ,从一个较大的字符串提取出一个子串 ,第二个参数是不想复制的第一个位置
-   `不可变字符串`,String 类没有提供用于修改字符串的方法,所以通过修改字符串变量来改变字符串

## Python

### [安装库及常用框架](https://germey.gitbooks.io/python3webspider/1.1-Python3%E7%9A%84%E5%AE%89%E8%A3%85.html)

注意,pip 安装和 pip3 安装路径不同,须统一安装方式
运行测试代码,新建.py 文件,在终端下或是 vscode 右键运行

-   `Docker` 安装(Fu\*\*)出错时,更新软件源,检查公钥问题,[详情](http://zyy1217.com/2016/08/25/%E7%8E%A9Docker%E6%8E%89%E8%BF%9B%E7%9A%84%E5%90%84%E7%A7%8D%E5%9D%91/),具体脚本式安装看[这个](https://www.jianshu.com/p/07e405c01880)
-   `yield` 关键字
    迭代（iteration）是一种操作,逐个获取元素的过程，就是「迭代」.迭代器（iterator）是一种对象,迭代协议指容器类需要包含的特殊方法,Python 中迭代协议和 for 循环绑在一起.

    生成器函数（generator function）和生成器（generator）: 生成器函数是一种特殊的函数；生成器则是特殊的迭代器

    ```Python
        def func():
        return 1

        def gen():
        yield 1
    ```

    除了返回值不相同,和普通函数没有太大区别.func() 是一个 int 类型的对象；而 gen() 则是一个迭代器对象.
    当函数内遇到 yield 关键字后,将返回生成器对象,变量保存(暂存),直到下一次迭代调用时,从之前暂存位置开始读取

    ```Python
        >>> f = fab(5)
        >>> f.next()
        1
        >>> f.next()
        1
        >>> f.next()
        2
        >>> f.next()
        3
        >>> f.next()
        5
        >>> f.next()
    ```

    参考: [(译)Python 关键字 yield 的解释(stackoverflow)](https://pyzh.readthedocs.io/en/latest/the-python-yield-keyword-explained.html),[理解 yield 关键字](https://liam.page/2017/06/30/understanding-yield-in-python/)

-   python 字符串可以被索引

    ```Python
      >>> word = 'Python'
      >>> word[0]
      'P'
      >>> word[5]
      'n'
      #可以是负数,负数代表从右边计算
      >>> word[-6]
      'P'
      #支持切割字符串
      >>> word[2:5]
      'tho'
      #简写(省略冒号前后)即使用默认值,冒号前省略,代表默认为0;省略省略冒号后,代表要切割的字符串的长度,即最后
      >>> word[:2]
      'Py'
      >>> word[4:]
      'on'
      >>> word[-2:]
      'on'
      #注意
      #尝试过大索引会报错,如word[89],但长度只有6
      #不可给索引赋值,可以尝试创建新的字符串拼接
    ```

## Odoo

[Odoo 开发手册 12 版](https://alanhou.org/odoo-12-development/),记录一下总体过程

[详情点这里](./Odoo/Odoo.md)

## 参考资料

太多，[书签](https://app.yinxiang.com/Home.action?login=true#n=2f7b3fe9-e2dd-4056-b36a-fadfa36642cf&s=s45&b=8a69d444-49ec-4ffd-991d-5acadd0b91ff&ses=4&sh=1&sds=5&)保存一下

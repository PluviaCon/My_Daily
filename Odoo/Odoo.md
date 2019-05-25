# Odoo 应用开发过程指南

[TOC]

根据中文[配置指南](https://alanhou.org/odoo-12-development/)来配置,慢慢记录过程

## 开发环境配置

安装示例有很详细的过程,开发是 Ubuntu 系统,所以选择这个来配置---- [Ubuntu 快速安装配置 Odoo 12](https://alanhou.org/odoo-12/)

```shell

  sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:10
  sudo docker run -v /www/odoo/addons:/mnt/extra-addons -p 8069:8069 --name odoo --link db:db -t odoo

  # docker run -dit --name ubuntuPP -v ${pwd}:/home  4b540083b58e /bin/bash

  docker container stop db
  docker container rm db
  docker container stop odoo
  docker container rm odoo

```

**注意事项 :**

> `psycopg2` 安装问题 :

在 pip3 安装过程中,出现`postgresql-server-dev-X.Y` 错误,[解决方案](http://landcareweb.com/questions/2208/nin-xu-yao-an-zhuang-postgresql-server-dev-x-ylai-gou-jian-fu-wu-qi-duan-kuo-zhan-huo-zhe-an-zhuang-libpq-devlai-gou-jian-ke-hu-duan-ying-yong-cheng-xu)

> `未安装软件包 libpng12-0` 问题 :

先卸载残留,然后下载文件安装,注意版本

```shell

sudo apt --fix-broken install
wget http://ftp.cn.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.49-1+deb7u2_amd64.deb

sudo apt install ./libpng12-0_1.2.49-1+deb7u2_amd64.deb

sudo dpkg -i wps-office_10.1.0.5672-a21_amd64.deb

```

> 事实证明,不行上 [Docker](https://hub.docker.com/_/odoo) .....fu\*\*

```shell
# 安装 PostgreSQL 容器
sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:10
# 安装 Odoo 服务容器
sudo docker run -p 8069:8069 --name odoo --link db:db -t odoo
```

docker 安装时注意镜像版本号,可以去官网拉去制定版本号安装,并映射目录,也可以在 docker run 之后查看启动命令输出,查看镜像里 odoo 插件的所在目录:

```shell
docker start imagename -a #输出docker信息
docker exec -u root -it imagename /bin/bash #进入docker 内部
#  ['/var/lib/odoo/addons/12.0', '/mnt/extra-addons', '/usr/lib/python3/dist-packages/odoo/addons']
```

如果遇见 Windos 下 Docker 和虚拟机启动冲突无法打开时,先关闭 Hyper-V,然后在开启就 OK 了.

## 模块

### 安装准备 : [具体详情](https://alanhou.org/odoo12-first-application/)

- 确保操作的目录是 Odoo 的 addons 路径

- 创建模块目录，并包含声明文件.初始化文件是需配置`__init__.py`来声明所需的模块,并配置`__manifest__.py`文件来描述文件

  `__manifest__.py`文件属性 :

  |         属性 | 描述                                                                                                                                                                    |
  | -----------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  |         name | 插件模块标题字符串                                                                                                                                                      |
  |  description | 功能描述长文件，通常为 RST 格式                                                                                                                                         |
  |       author | 作者姓名，本处为一个字符串，可以是逗号分隔的一系列姓名                                                                                                                  |
  |      depends | 一个依赖插件模块列表，在模块安装时会先安装这些插件                                                                                                                      |
  |  application | 一个布尔型标记，代表模块是否在应用列表中以 app 展现                                                                                                                     |
  |      summary | 显示为模块副标题的字符串                                                                                                                                                |
  |      version | 默认为 1.0，应遵守版本号规则. 建议在模块版本号前加上 Odoo 版本，如 12.0.1.0                                                                                             |
  |      license | 默认为 LGPL-3                                                                                                                                                           |
  |      website | 了解模块更多信息的 URL，可以帮助人们查看更多文档或提供文件 bug 和建议的跟踪                                                                                             |
  |     category | 带有模块功能性分类字符串，缺省为 Uncategorized. 已有分类可通过安全组表单（位于 Settings > Users & Companies > Groups）的 Application 字段下拉列表查看（需开启调试模式） |
  |  installable | 默认为 True，但可以通过设置为 False 来禁用模块                                                                                                                          |
  | auto_install | 若设置为 True，在其依赖已安装时会自动安装，用于胶水模块，用于同一实例上两个模块安装后功能的连接.                                                                        |

- 可选择为模块添加一个图标
- 如打算对外发布，为模块选择一个证书
- 如果安装失败,检查用户权限和 odoo 版本原因,有可能是 odoo 版本更新后语法不同所致
- 可以再 web 端操作的,就不要去改代码了....

### 插件模块详解 ---- 具体参照详情

一个新的模块,首先要确定引入的资源,继承的模块,都在`__manifest__.py`中有体现.
`depends`是插件要引入的模块列表,在安装是会自动获取列表里的模块.
`views` 目录是所有视图层的存放目录,主要定义 form 或是顶级菜单.
`security` 目录存放权限相关的 csv 文件

首先,创建`menu`(顶级菜单文件),里面存放安装后首页看到的视图,一般有两种标签 : `menuitem` 和 `record`

`<menuitem>` 标签定义菜单项和子菜单的操作,菜单项和操作均存储在数据表中,其中的元素向`ir.ui.menu`模型写入记录,`id` 属性是唯一标示每个数据元素的.

`<record>` 标签定义具体的操作,`id` 属性对应的`menuitem` 标签的`action` ,即是菜单项的具体实现方法

```xml
  <menuitem name="中医" id="menu_zhongyi_root" web_icon="zhong_yi,static/description/icon.png" />

  <menuitem name="门诊" id="menu_menzhen" parent="menu_zhongyi_root" sequence='10' />
  <menuitem name="药房" id="menu_zhongyao" parent="menu_zhongyi_root" sequence='20' />
  <menuitem name="资源" id="menu_ziyuan" parent="menu_zhongyi_root" sequence='30' />
  <menuitem name="运营" id="menu_yunying" parent="menu_zhongyi_root" sequence='40' />
  <menuitem name="数据" id="menu_shuju" parent="menu_zhongyi_root" sequence='50' />
  <menuitem name="配置" id="menu_peizhi" parent="menu_zhongyi_root" sequence='50' />


  <!-- 门诊 -->
  <record model="ir.actions.act_window" id="action_menzhen_guahao">
    <field name="name">挂号</field>
    <field name="res_model">crm.lead</field>
    <field name="view_mode">tree,form</field>
  </record>
  <menuitem name="挂号" id="menu_menzhen_guahao" parent="menu_menzhen" sequence='10' action="action_menzhen_guahao" />

```

`record` 标签里的 `model` 属性,对应不同的模型,用来区分用途; `field` 标签用来添加字段.具体参照官方文档的[说明](https://www.odoo.com/documentation/12.0/howtos/backend.html#relations-between-models)

在配置好模块的 xml 后,需要在`models` 目录下添加模型的`.py` 文件,每一个模型对应一个文件,创建后在`models` 目录下的`__init__.py` 下引入模块 --- 模型的[具体属性](https://www.odoo.com/documentation/12.0/reference/orm.html#model-reference)

所有的表单视图都存储在数据库的`ir.ui.view` 模型中,在`record`标签中运入 model`ir.ui.view`.

这个 ir.ui.view 记录有三个字段值：name, model 和 arch. 另一个重要元素是记录 id，它定义了一个可在其它记录中引用的 XML ID 标识符.

最重要的字段是`arch`，它包含了视图的定义，在 XML 代码中我们做了高亮显示（博客主题问题无法显示）. `<form>`标签定义了视图类型并包含视图结构.

### 模块继承

继承的方式有很多种,继承内置模块或是自定义模块,或是拓展已存在的模块

#### 原模型继承

拓展模块(继承)可以用 python 的类属性 `_inherit`,指定了被扩展的模块.通过 `_inherit` 指定被继承模块后我们新创建的类能获得父类模块的所有功能.因此只要对需要修改的地方进行重构.

```python
  from odoo import models,fields,api

  class TodoTask(models.Model):
    _inherit = 'todo.task'
    user_id = fields.Many2one('res.users', string='Responsible')
    date_deadline = fields.Date('Deadline')
```

`_inherit` 作为关键属性:告诉了 Odoo 我们建立的’TodoTask’这个 class 是继承并自’todo.task’.注意点:`_name` 属性在这里没有出现,因为它已经从’todo.task’中被继承了.

可以把这个想成是对模型定义的一个引用，在原处做了一个修改。可以添加字段、修改已有字段、修改模型类属性甚至是包含业务逻辑的方法

user_id 字段代表了来自’res.users’这个模型的用户,它是一个 Many2one 字段,从数据库角度来说，就是一个外键的作用.date_deadline 是一个简单的日期字段.我们更新我们的’todo_user’模块后进入 Technical | Database Structure | Models 菜单.搜索 todo.task 模型会发现其中新增了我们刚添加的 2 个字段.

使用了`_inherite` 属性,没有使用`_name`.所以继承模块还是使用 todo.task 的数据库表结构. 使用`_name` 属性,可以创建一个新的数据库来复制被继承模块的功能(创建所继承模型的拷贝，成为一个新模型).

```python
  from odoo import models
  class TodoTask(models.Model):
    _name = 'todo.task'
    _inherit = 'mail.thread'
```

#### 视图继承

表单,列表,搜索视图(在 web 端表示为具体页面操作)都是被`arch`所定义的 XML 结构.为了拓展视图,需要修改 xml,具体做法是限定为到要修改的 xml 位置,然后进行插入修改或是完全修改.

一般来说,开发者模式会提供查看视图的名称和具体的模型,可以在前端界面找到.在引入一个概念--`记录模型`&`外部ID`.

```xml

  <record model="ir.ui.view" id="view_zy_zhongyao_inherit_form">
    <field name="name">中药</field>
    <field name="model">product.template</field>
    <field name="inherit_id" ref="product.product_template_only_form_view" />
    <field name="arch" type="xml">
      <xpath expr="//page[1]" position="before">
        <page string="中药学">
          <group>
            <group>
              <field name="zy_wei" widget="many2many_tags" />
              <field name="zy_qi" widget="many2many_tags" />
              <field name="zy_jing" widget="many2many_tags" />
            </group>
            <group>
            </group>
          </group>
        </page>
      </xpath>
    </field>
  </record>

```

`inherit_id` 字段定义了需要被继承的视图.通过 ref 属性传入被继承的视图的外部 ID(External identifiers),使用`Xpath`来定位 XML 元素是最合适的,举例来说,定位到`<field name="is_done">`这个元素可以使用表达式`//field[@name] = 'is_done'`来实现,或是进行缩写,通过`position`属性

```xml
  <field name="is_done" position="before">
    <field name="date_deadline"/>
  </field>
```

**注意** :
当一个字段多次出现在同一个 view 中,还是需要使用 Xpath 表达式,因为缩写形式在查找到第一个元素后就停止继续定位了.
在 9.0 以前，string 属性(显示标签文本）也可作为继承定位符。在 9.0 之后则不再允许。这一限制主要源自这些字符串的语言翻译机制。
`position`属性有这几个具体值:

- `after` 添加到匹配节点后
- `before` 添加到匹配节点前面
- `inside` 默认值,添加在节点里
- `replace` 代替匹配到的节点,如果使用空内容相当于删除了匹配到的元素
- `attributes` 修改匹配元素的属性 , 使用 `<attribute name="attr-name">` 来进行新属性的设置举例

```xml
  <field name="active" position="attributes">
    <attribute name='invisible'>1</attribute>
  </field>

  <!--
  这段代码表示把’acitve’这个字段隐藏起来
  实际的开发中,我们使用添加’invisible’这个属性来让字段在页面隐藏而尽量避免使用’replace’,
  因为’replace’会删除我们定位到的节点(有时候这些节点只是作为一个占位符，当replace删除后会改变整个视图的结构)
  -->
```

除了 attributes 定位，上述定位符可与带 position=”move”的子元素合并。效果是将子定位符目标节点移到父定位符目录位置。

```xml
  <field name="target_field" position="after">
      <field name="my_field" position="move"/>
  </field>
  <!-- position=”move”子定位符是 Odoo 12中新增的，之前的版本中没有 -->
```

示例: 添加 search 视图

```xml
  <record id="view_filter_todo_task_inherited" model="ir.ui.view">
    <field name="name">Todo Task filter Inherited</field>
    <field name="model">todo.task</field>
    <field name="inherit_id" ref="todo_app.view_filter_todo_task"/>
    <field name="arch" type="xml">
        <field name="name" position="after">
            <field name="user_id"/>
            <filter name="filter_my_tasks" string="My Tasks"
                    domain="[('user_id','in',[uid,False])]"/>
            <filter name="filter_not_assigned" string="Not Assigned"
                    domain="[('user_id','=',False)]"/>
        </field>
    </field>
  </record>
```

`<record id=”x” model=”y”>`数据加载元素实际是对 y 模型进行插入或更新操作。若不存在记录 x，则被创建，否则被更新/覆盖。其它模块中的记录可通过`<module>.<identifier>`全局标识符访问，因此可以在我们的模块中重写其它模块中已写入的数据。(点号是保留符号，用于分隔模块名和对象标识符，所以在标识符名中不要使用点号，而应使用下划线字符。)

```xml
  <odoo>
      <record id="library_app.library_group_user" model="res.groups">
          <field name="name">Librarian</field>
      </record>
  </odoo>
```

#### 代理继承

之前的模型继承,即是经典继承.还有一种代理继承,场景是不通过复制原模型的情况下,复用模型里的字段,实现避免结构冗余.使用代理继承无需复制数据即可在数据库中复用数据结构，这通过将一个模型嵌入另一个来实现。UML 中这种称作组合(composition)关系：父类无需子类即可存在，而子类必须要有父类才能存在。

```python
  from odoo import fields, models

  class Member(models.Model):
      _name = 'library.member'
      _description = 'Library Member'
      card_number = fields.Char()
      partner_id = fields.Many2one(
          'res.partner',
          delegate=True,
          ondelete='cascade',
          required=True)
```

代理继承可通过如下组合来进行替代：

- 父模型中的一个 many-to-one 字段
- 重载 create()方法自动创建并设置父级记录
- 父字段中希望暴露的特定字段的关联字段

### javascript 模块

我所见到的模块化,都是使用`odoo.define` 定义模块,然后里面使用`Widget`来进行操作.可以仔细看一下这篇讲的 odoo[渲染机制](https://qhtao.github.io/2017/04/18/odoo-client-develop).

```js
odoo.define('muk_web_utils.FormRenderer', function(require) {
  'use strict'

  var core = require('web.core')

  var FormRenderer = require('web.FormRenderer')

  var _t = core._t
  var QWeb = core.qweb

  FormRenderer.include({
    _updateView: function($newContent) {
      this._super.apply(this, arguments)
      _.each(
        this.allFieldWidgets[this.state.id],
        function(widget) {
          if (widget.attrs.widget === 'module_boolean') {
            var inputID = this.idsForLabels[widget.name]
            var $widgets = this.$('.o_field_widget[name=' + widget.name + ']')
            var $label = inputID
              ? this.$('.o_form_label[for=' + inputID + ']')
              : $()
            widget.renderWithLabel($label.eq($widgets.index(widget.$el)))
          }
        },
        this
      )
    }
  })
})
```

两个参数,第一个为模块名,第二个是接受`require`的方法.通过 `require` 来导入需要的模块，并且显示声明所输出的对象,使用 renturn 关键字实现导出.

在开发时,使用`assets 开发者模式`进行实时查看更好,记得保持网络畅通(访问`https://apps.odoo.com`的畅通).

### 其他安装

#### wine 安装过程

[安装过程(源码安装)](https://www.tecmint.com/install-wine-in-rhel-centos-and-fedora/),CentOS7 系统下安装.
注意不要使用 root 用户安装,风险官网有提示.

##### 问题

在 64 位系统下安装成功 64 位,可是运行 32 位程序时报错.换成 32 位 wine 实验.卸载方法: [官方卸载](https://wiki.winehq.org/FAQ#How_do_I_uninstall_Wine.3F)

在安装 32 位过程中,一直提示依赖减少,第一个安装以下依赖解决:

```shell
  sudo yum install xulrunner.i686
  sudo yum install ia32-libs.i686
  sudo yum install libX11-devel.i686
  ./configure --without-freetype
```

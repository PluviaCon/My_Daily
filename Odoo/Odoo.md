# Odoo 应用开发框架过程指南

根据中文配置[指南](https://alanhou.org/odoo-12-development/)和公司的具体要求来配置,慢慢记录过程

## 开发环境配置

安装示例有很详细的过程,开发是 Ubuntu 系统,所以选择这个来配置---- [Ubuntu 快速安装配置 Odoo 12](https://alanhou.org/odoo-12/)

```shell

  sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:10
  sudo docker run -v /www/odoo/addons:/mnt/extra-addons -p 8069:8069 --name odoo --link db:db -t odoo

  docker container stop db
  docker container rm db
  docker container stop odoo
  docker container rm odoo

```

**注意事项**

- `psycopg2` 安装问题 :

  在 pip3 安装过程中,出现`postgresql-server-dev-X.Y` 错误,[解决方案](http://landcareweb.com/questions/2208/nin-xu-yao-an-zhuang-postgresql-server-dev-x-ylai-gou-jian-fu-wu-qi-duan-kuo-zhan-huo-zhe-an-zhuang-libpq-devlai-gou-jian-ke-hu-duan-ying-yong-cheng-xu)

- `未安装软件包 libpng12-0` 问题 :
  先卸载残留,然后下载文件安装,注意版本

  ```shell

    sudo apt --fix-broken install
    wget http://ftp.cn.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.49-1+deb7u2_amd64.deb

    sudo apt install ./libpng12-0_1.2.49-1+deb7u2_amd64.deb

    sudo dpkg -i wps-office_10.1.0.5672-a21_amd64.deb

  ```

- 事实证明,不行上 [Docker](https://hub.docker.com/_/odoo) .....fu\*\*

  ```shell
    # 安装 PostgreSQL 容器
    sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:10
    # 安装 Odoo 服务容器
    sudo docker run -p 8069:8069 --name odoo --link db:db -t odoo
  ```

  docker 安装时注意镜像版本号,可以去官网拉去制定版本号安装,并映射目录,也可以在docker run 之后查看启动命令输出,查看镜像里 odoo 插件的所在目录

## 模块插件

### 安装准备 : [具体详情](https://alanhou.org/odoo12-first-application/)

- 确保操作的目录是 Odoo 的 addons 路径

- 创建模块目录，并包含声明文件

  初始化文件是需配置`__init__.py`来声明所需的模块,并配置`__manifest__.py`文件来描述文件

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
- 如果安装失败,检查用户权限和odoo版本原因,有可能是odoo版本更新后语法不同所致
- 可以再web端操作的,就不要去改代码了....

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


在配置好模块的xml后,需要在`models` 目录下添加模型的`.py` 文件,每一个模型对应一个文件,创建后在`models` 目录下的`__init__.py` 下引入模块 --- 模型的[具体属性](https://www.odoo.com/documentation/12.0/reference/orm.html#model-reference)


所有的表单视图都存储在数据库的`ir.ui.view` 模型中,在`record`标签中运入model`ir.ui.view`.

这个ir.ui.view记录有三个字段值：name, model和 arch. 另一个重要元素是记录 id，它定义了一个可在其它记录中引用的XML ID标识符.

最重要的字段是`arch`，它包含了视图的定义，在 XML 代码中我们做了高亮显示（博客主题问题无法显示）. `<form>`标签定义了视图类型并包含视图结构.

### 模块继承

继承的方式有很多种,继承内置模块或是自定义模块,或是拓展已存在的模块

拓展模块可以用python的类属性 `_inherit`,指定了被扩展的模块.通过 `_inherit` 指定被继承模块后我们新创建的类能获得父类模块的所有功能.因此只要对需要修改的地方进行重构.

```python
  from odoo import models,fields,api

  class TodoTask(models.Model):
    _inherit = 'todo.task'
    user_id = fields.Many2one('res.users', string='Responsible')
    date_deadline = fields.Date('Deadline')
  
  # _inherit作为关键属性:告诉了Odoo我们建立的’TodoTask’这个class是继承并自’todo.task’. 
  # 注意点:_name属性在这里没有出现,因为它已经从’todo.task’中被继承了

  # user_id字段代表了来自’res.users’这个模型的用户,它是一个Many2one字段,从数据库角度来说，就是一个外键的作用.
  # date_deadline是一个简单的日期字段.我们更新我们的’todo_user’模块后进入Technical | Database Structure | Models菜单.
  # 搜索todo.task模型会发现其中新增了我们刚添加的2个字段.
```

使用了_inherite属性,没有使用_name.所以继承模块还是使用todo.task的数据库表结构. 使用`_name` 属性,可以创建一个新的数据库来复制被继承模块的功能

```python
  from odoo import models
  class TodoTask(models.Model):
    _name = 'todo.task'
    _inherit = 'mail.thread'
```



### view视图

表单,列表,搜索视图(在web端表示为具体页面操作)都是被`arch`所定义的XML结构.为了拓展视图,需要修改xml,具体做法是限定为到要修改的xml位置,然后进行插入修改或是完全修改

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

`inherit_id` 字段定义了需要被继承的视图.通过ref属性传入被继承的视图的外部ID(External identifiers),使用`Xpath`来定位XML元素是最合适的,举例来说,定位到`<field name="is_done">`这个元素可以使用表达式`//field[@name] = 'is_done'`来实现

或是进行缩写,通过`position`属性

```xml
  <field name="is_done" position="before">
    <field name="date_deadline"/>
  </field>
```

**注意** : 当一个字段多次出现在同一个view中,还是需要使用Xpath表达式,因为缩写形式在查找到第一个元素后就停止继续定位了.`position`属性有这几个具体值:

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

示例: 添加search 视图

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


























































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
  |      version | 默认为 1.0，应遵守版本号规则。建议在模块版本号前加上 Odoo 版本，如 12.0.1.0                                                                                             |
  |      license | 默认为 LGPL-3                                                                                                                                                           |
  |      website | 了解模块更多信息的 URL，可以帮助人们查看更多文档或提供文件 bug 和建议的跟踪                                                                                             |
  |     category | 带有模块功能性分类字符串，缺省为 Uncategorized。已有分类可通过安全组表单（位于 Settings > Users & Companies > Groups）的 Application 字段下拉列表查看（需开启调试模式） |
  |  installable | 默认为 True，但可以通过设置为 False 来禁用模块                                                                                                                          |
  | auto_install | 若设置为 True，在其依赖已安装时会自动安装，用于胶水模块，用于同一实例上两个模块安装后功能的连接。                                                                       |

- 可选择为模块添加一个图标
- 如打算对外发布，为模块选择一个证书

### 插件模块详解 ---- 具体参照详情

一个新的模块,首先要确定引入的资源,继承的模块,都在`__manifest__.py`中有体现.
`depends`是插件要引入的模块列表,在安装是会自动获取列表里的模块.
`views` 目录是所有视图层的存放目录,主要定义 form 或是顶级菜单.
`security` 目录存放权限相关的 csv 文件

首先,创建`menu`(顶级菜单文件),里面存放安装后首页看到的视图,一般有两种标签 : `menuitem` 和 `record`

`<menuitem>` 标签定义菜单项和子菜单的操作,菜单项和操作均存储在数据表中,其中的元素向`ir.ui.menu`模型写入记录,`id` 属性是唯一标示每个数据元素的.

`<record>` 标签定义具体的操作`action`,`id` 属性对应的`menuitem` 标签的`action` ,即是菜单项的具体实现方法

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



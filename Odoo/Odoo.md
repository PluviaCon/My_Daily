# Odoo 应用开发框架过程指南

根据中文配置[指南](https://alanhou.org/odoo-12-development/)和公司的具体要求来配置,慢慢记录过程

## 开发环境配置

安装示例有很详细的过程,开发是 Ubuntu 系统,所以选择这个来配置---- [Ubuntu 快速安装配置 Odoo 12](https://alanhou.org/odoo-12/)

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

#!/bin/bash


# 安装依赖包：
sudo apt-get install -y python3-pip python-psycopg2 libpq-dev

pip3 install Babel passlib lxml decorator docutils ebaysdk feedparser gevent greenlet html2text Jinja2 Mako MarkupSafe mock num2words ofxparse Pillow psutil psycogreen psycopg2 pydot pyparsing PyPDF2 pyserial python-dateutil python-openid pytz pyusb PyYAML qrcode reportlab requests six suds-jurko vatnumber vobject Werkzeug XlsxWriter xlwt xlrd

# 安装数据库
sudo apt-get install -y postgresql


sudo su - postgres
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo

# 安装中文字体：
sudo apt-get install ttf-wqy-zenhei -y
sudo apt-get install ttf-wqy-microhei -y
 

# 安装报表所需的wkhtmltopdf

wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.trusty_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.trusty_amd64.deb
sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin

# 
wget http://ftp.cn.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u3_amd64.deb
  
sudo apt install ./libpng12-0_1.2.50-2+deb8u3_amd64.deb


cd ~/odoo12
./odoo-bin -s
# 设置配置文件：
sudo mkdir /etc/odoo
sudo cp /home/odoo/.odoorc /etc/odoo/odoo.conf
sudo chown -R odoo /etc/odoo
# 设置日志：
sudo mkdir /var/log/odoo
sudo chown odoo /var/log/odoo
# 修改配置：
sudo vi /etc/odoo/odoo.conf
 
[options]
logfile = /var/log/odoo/odoo.log
logrotate = True

###

sudo vi /lib/systemd/system/odoo.service
#添加代码
[Unit]
Description=Odoo
After=postgresql.service
[Service]
Type=simple
User=odoo
Group=odoo
ExecStart=/home/kongyu/Documents/odoo12/odoo-bin -c /etc/odoo/odoo.conf
[Install]
WantedBy=multi-user.target

#注册为系统服务：
sudo systemctl enable odoo.service
# 启动服务
sudo systemctl start odoo<code>

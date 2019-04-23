# -*- coding: utf-8 -*-
from odoo import models, fields, api


class qingjiadan(models.Model):
    _name = 'qingjia.qingjiadan'
    name = fields.Char(string="申请人")
    days = fields.Integer(string="天数")
    startdate = fields.Date(string="开始日期")
    reason = fields.Text(string="请假事由")

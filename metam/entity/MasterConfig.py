#!/usr/bin/env python
#-*-coding:utf-8-*-


'''
Created on 2017年8月17日

@Author: xin peng
@Description: 
'''

from django.db import models

class MasterConfig(models.Model):
    cluster_name = models.CharField('集群名称', max_length=50)
    master_host = models.CharField('主库地址', max_length=200)
    master_port = models.IntegerField('主库端口', default=3306)
    master_user = models.CharField('登录主库的用户名', max_length=100)
    master_password = models.CharField('登录主库的密码', max_length=300)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now=True)

    def __str__(self):
        return self.cluster_name
    class Meta:
        verbose_name = u'主库地址'
        verbose_name_plural = u'主库地址'

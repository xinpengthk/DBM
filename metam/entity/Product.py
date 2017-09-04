#!/usr/bin/env python
#-*-coding:utf-8-*-

'''
Created on 2017年8月17日

@Author: xin peng
@Description: product model
'''

from django.db import models

class Product(models.Model):
    
    # 定义状态项
    PRD_STATUS_CHOICE = (
            (0, u'未上线'),
            (1, u'已上线'),
            (2, u'已下线'),        
        )
    
    isDel = (
            (0, u'未删除'),
            (1, u'已删除'),
        )
    
    productId = models.BigAutoField('产品线编号', name='product_id', null=False, primary_key=True, max_length=20)
    productName = models.CharField('产品线名称', name='product_name', unique=True, null=False, blank=False, max_length=32, help_text='请输入产品线名称')
    productStatus = models.SmallIntegerField('产品线状态', name='product_status', null=False, blank=False, choices=PRD_STATUS_CHOICE, default=1)
    productDesc = models.CharField('产品线描述', name='product_desc', max_length=128, help_text='请输入产品线描述')
    isDel = models.SmallIntegerField('该记录是否被删除', name='is_del', choices=isDel, default=0)
    createTime = models.DateTimeField('记录创建时间', name='created_time', auto_now_add=True)
    updateTime = models.DateTimeField('记录更新时间', name='updated_time', auto_now=True)

    def __str__(self):
        return self.product_name
    class Meta:
        verbose_name = u'产品线管理'
        verbose_name_plural = u'产品线管理'


        
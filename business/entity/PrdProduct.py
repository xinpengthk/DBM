#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: product model
'''


from django.db import models
from business.entity.PrdBusiness import PrdBusiness

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

PRODUCT_STATUS_CHOICES = (
    (0, '未上线'),
    (1, '已上线'),
    (2, '已下线'),    
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class PrdProduct(models.Model):
    productId = models.BigAutoField(db_column='product_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )
    
    businessId = models.ForeignKey(
        PrdBusiness,
        on_delete=models.DO_NOTHING,
        db_column='business_id',
        db_index=False,        
        verbose_name='业务线编号，外键',
        help_text='请选择业务线',
        
    )
    
    productName = models.CharField(db_column='product_name',
        max_length=32,
        null=False,
        blank=False,
        db_index=True,
        verbose_name='产品线名称',
        help_text='请输入产品线名称!',
    )

    productStatus = models.SmallIntegerField(db_column='product_status',
        null=False,
        blank=False,
        choices=PRODUCT_STATUS_CHOICES,
        default=1,
        verbose_name='产品线状态',
        help_text='产品线状态，0：未上线，1：已上线，2：已下线',
    )
    
    productDesc = models.CharField(db_column='product_desc',
         max_length=128,
         null=False,
         blank=False,
         verbose_name='产品线描述',
         help_text='产品线描述！',
    )

    isDel = models.SmallIntegerField(db_column='is_del',
        null=False,
        blank=False,
        choices=IS_DEL_CHOICES,
        default=0,
        verbose_name='该记录是否被删除',
        help_text='该记录是否被删除，0：未删除，1：已删除，默认为0',
    )
 
    createdTime = models.DateTimeField(db_column='created_time', 
        blank=True,
        null=True,
        auto_now_add=True,
        verbose_name='记录创建时间',
        help_text='该记录创建时间',
    )
    
    updatedTime = models.DateTimeField(db_column='updated_time', 
        blank=True,
        null=True,
        auto_now=True,
        verbose_name='记录最后更新时间',
        help_text='记录最后更新时间',
    )

    REQUIRED_FIELDS = ['businessId', 'productName', 'productStatus', 'productDesc', ]

    def __str__(self):              # __unicode__ on Python 2
        return self.productName

    def get_product_name(self):
        # The user is identified by their email address
        return self.productName

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_perms(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    class Meta:    
        db_table = 'prd_product' 
        verbose_name = u'产品线表'
        verbose_name_plural = u"产品线表"
        

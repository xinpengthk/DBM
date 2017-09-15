#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: business model
'''


from django.db import models

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

BUSINESS_STATUS_CHOICES = (
    (0, '未上线'),
    (1, '已上线'),
    (2, '已下线'),    
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class PrdBusiness(models.Model):
    businessId = models.BigAutoField(db_column='business_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )
    
    businessName = models.CharField(db_column='business_name',
        max_length=32,
        unique=True,
        null=False,
        blank=False,
        verbose_name='业务线名称',
        help_text='请输入业务线名称!',
    )

    businessStatus = models.SmallIntegerField(db_column='business_status',
        null=False,
        blank=False,
        choices=BUSINESS_STATUS_CHOICES,
        default=1,
        verbose_name='业务线状态',
        help_text='业务线状态，0：未上线，1：已上线，2：已下线',
    )
    
    businessDesc = models.EmailField(db_column='business_desc',
         max_length=128,
         null=False,
         blank=False,
         verbose_name='业务线描述',
         help_text='业务线描述！',
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

    REQUIRED_FIELDS = ['businessName', 'businessStatus', 'businessDesc', ]

    def __str__(self):              # __unicode__ on Python 2
        return self.businessName

    def get_business_name(self):
        # The user is identified by their email address
        return self.businessName

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
        db_table = 'prd_business' 
        verbose_name = u'业务线表'
        verbose_name_plural = u"业务线表"
        

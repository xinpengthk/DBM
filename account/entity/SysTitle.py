#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: title model
'''


from django.db import models

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

TITLE_STATUS_CHOICES = (
    (0, '未激活'),
    (1, '激活'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

TITLE_TYPE_CHOICES = (
    (100, '普通员工'),
    (101, '项目ledear'),
    (102, '部门负责人'),
    (103, 'XXO'),
    (104, '临时用户'),
)

class SysTitle(models.Model):
    titleId = models.BigAutoField(db_column='title_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )
    
    titleName = models.CharField(db_column='title_name',
        max_length=32,
        unique=True,
        null=False,
        blank=False,
        verbose_name='岗位名称',
        help_text='请输入岗位名称',
    )

    titleType = models.SmallIntegerField(db_column='title_type',
        null=False,
        blank=False,
        choices=TITLE_TYPE_CHOICES,
        verbose_name='岗位类型',
        help_text='岗位类型，100:普通员工，101:项目ledear，102:部门负责人，103:XXO，104:临时用户',
    )

    titleStatus = models.SmallIntegerField(db_column='title_status',
        null=False,
        blank=False,
        choices=TITLE_STATUS_CHOICES,
        default=1,
        verbose_name='岗位激活状态',
        help_text='岗位激活状态，0：未激活，1：激活',
    )
    
    titleDesc = models.CharField(db_column='title_desc',
         max_length=128,
         null=False,
         blank=False,
         verbose_name='岗位描述',
         help_text='请输入岗位描述！',
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

    REQUIRED_FIELDS = ['titleName', 'titleType', 'titleStatus', 'titleDesc', ]

    def __str__(self):              # __unicode__ on Python 2
        return self.titleName

    def get_title_name(self):
        # The user is identified by their email address
        return self.titleName

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
        db_table = 'sys_title' 
        verbose_name = u'系统岗位表'
        verbose_name_plural = u"系统岗位表"
    
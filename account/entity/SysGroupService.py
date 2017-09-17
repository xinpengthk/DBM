#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: group service model
'''


from django.db import models

from account.entity.SysGroup import SysGroup
from business.entity.PrdService import PrdService


BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class SysGroupService(models.Model):
    groupServiceId = models.BigAutoField(db_column='group_service_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )
    
    groupId = models.ForeignKey(SysGroup, 
        on_delete=models.CASCADE, 
        db_index=False,
        verbose_name='用户组 ID', 
        help_text='用户组 ID',
    )
    
    serviceId = models.ForeignKey(PrdService, 
        on_delete=models.CASCADE, 
        db_index=False,
        verbose_name='服务 ID', 
        help_text='服务 ID',
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

    REQUIRED_FIELDS = ['serviceId', 'groupID', 'isDel', ]

    def __str__(self):              # __unicode__ on Python 2
        return '<GroupID:%s, ServiceId:%s>' %(self.groupId, self.serviceId)

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
        db_table = 'sys_group_service' 
        verbose_name = u'用户服务关联表'
        verbose_name_plural = u"用户服务关联表"
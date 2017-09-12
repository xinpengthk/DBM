#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: group model
'''


from django.db import models

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class SysUserGroup(models.Model):
    groupId = models.BigIntegerField(db_column='group_id', 
        verbose_name='主键ID 1', 
        help_text='主键ID 1',
    )
    
    userId = models.BigIntegerField(db_column='user_id', 
        verbose_name='主键ID 2', 
        help_text='主键ID 2',
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

    REQUIRED_FIELDS = ['groupId', 'userId', ]

    def __str__(self):              # __unicode__ on Python 2
        return '<GroupId:%s UserId:%s>' %(self.groupId, self.userId)

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
        db_table = 'sys_user_group' 
        verbose_name = u'员工项目组关联表'
        verbose_name_plural = u"员工项目组关联表"
        

#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: department model
'''


from django.db import models

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

DEPT_STATUS_CHOICES = (
    (0, '未激活'),
    (1, '激活'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class SysDept(models.Model):
    deptId = models.BigAutoField(db_column='dept_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )
    
    deptName = models.CharField(db_column='dept_name',
        max_length=32,
        unique=True,
        null=False,
        blank=False,
        verbose_name='部门名称',
        help_text='请输入部门名称',
    )

    deptLoc = models.CharField(db_column='dept_loc',
        max_length=32,
        null=False,
        blank=False,
        verbose_name='部门工作地点',
        help_text='请输入部门工作地点',
    )

    deptStatus = models.SmallIntegerField(db_column='dept_status',
        null=False,
        blank=False,
        choices=DEPT_STATUS_CHOICES,
        default=0,
        verbose_name='部门激活状态',
        help_text='部门激活状态，0：未激活，1：激活',
    )
    
    deptDesc = models.EmailField(db_column='dept_desc',
         max_length=128,
         null=False,
         blank=False,
         verbose_name='部门描述',
         help_text='请输入部门描述！',
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

    REQUIRED_FIELDS = ['deptName', 'deptLoc', 'deptStatus', 'deptDesc', ]

    def __str__(self):              # __unicode__ on Python 2
        return self.deptName

    def get_dept_name(self):
        # The user is identified by their email address
        return self.deptName

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
        db_table = 'sys_dept' 
        verbose_name = u'系统部门表'
        verbose_name_plural = u"系统部门表"
        

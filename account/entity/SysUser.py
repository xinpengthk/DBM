#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: user model
'''

from django.db import models
# from account.entity.SysDept import SysDept
# from account.entity.SysTitle import SysTitle

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

USER_STATUS_CHOICES = (
    (0, '未激活'),
    (1, '激活'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class SysUser(models.Model):
    userId = models.BigAutoField(db_column='user_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )

    deptId = models.ForeignKey('SysDept', 
        on_delete=models.CASCADE,
        db_column='dept_id',
        verbose_name='部门编号，外键',
        help_text='请选择部门',
    )
    
    titleId = models.ForeignKey('SysTitle',
        on_delete=models.CASCADE,
        db_column='title_id',
        verbose_name='职位编号，外键',
        help_text='请输入职位',
    )
    
    userMgrid = models.ForeignKey('SysUser',
#         on_delete=models.SET_NULL,
        db_column='user_mgrid',
        verbose_name='用户领导id',
        help_text='用户领导id，0为管理员用户，自外键',
    )
    
    userRealName = models.CharField(db_column='user_realname',
        max_length=32,
        unique=True,
        null=False,
        blank=False,
        verbose_name='用户真实姓名',
        help_text='请输入用户真实姓名',
    )
    
    userLoginName = models.CharField(db_column='user_login_name',
        max_length=32,
        unique=True,
        null=False,
        blank=False,
        verbose_name='用户登录名',
        help_text='请输入用户登录名',
    )

    userPwd = models.CharField(db_column='user_pwd',
        max_length=64,
        null=False,
        blank=False,
        verbose_name='用户密码',
        help_text='请输入用户密码',
    )

    userRole = models.SmallIntegerField(db_column='user_role',
        null=False,
        blank=False,
        choices=BOOLEAN_CHOICES,
        default=0,
        verbose_name='是否为项目leader',
        help_text='是否为项目leader，1：是，0：否',
    )
    
    userStatus = models.SmallIntegerField(db_column='user_status',
        null=False,
        blank=False,
        choices=USER_STATUS_CHOICES,
        default=1,
        verbose_name='用户激活状态',
        help_text='用户激活状态，0：未激活，1：激活',
    )

    userEmail = models.EmailField(db_column='user_email',
         max_length=128,
         null=False,
         blank=False,
         unique=True,
         verbose_name='用户邮箱',
         help_text='请输入邮箱！',
    )
    
    userPhone = models.CharField(db_column='user_phone',
         max_length=11,
         null=False,
         blank=False,
         unique=True,
         verbose_name='用户手机号',
         help_text='请输入手机号！',
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

    REQUIRED_FIELDS = ['userRealName']

    def __str__(self):              # __unicode__ on Python 2
        return self.userRealName
    
    def get_user_realname(self):
        return self.userRealName

    def get_user_loginname(self):
        # The user is identified by their email address
        return self.userLoginName

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

    @property
    def user_role(self):
        return self.userRole

    class Meta:    
        db_table = 'sys_user' 
        verbose_name = u'用户信息'
        verbose_name_plural = u"用户信息"

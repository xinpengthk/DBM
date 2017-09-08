#!/usr/bin/env python
#-*-coding:utf-8-*-

'''
Created on 2017-09-08

@Author: XinPeng
@Description: user model
'''

from django.db import models
from django.utils import timezone
from django.contrib.gis.db.models.functions import Length

  user_role tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为项目leader，1：是，0：否',
  user_mgrid bigint(20) NOT NULL COMMENT '用户领导id，0为管理员用户，自外键',
  user_status tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户激活状态，0：未激活，1：激活',
  user_email varchar(128) NOT NULL COMMENT '用户邮箱',
  user_phone varchar(11) NOT NULL COMMENT '用户手机号',
  is_del tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除，0：未删除，1：已删除，默认为0',
  created_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  updated_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',

class SysUser(models.Model):
    userId = models.BigAutoField(db_column='user_id', primary_key=True, verbose_name='主键ID', help_text='主键自增ID')
    deptId = models.ForeignKey('SysDept', on_delete=models.CASCADE, db_column='dept_id', verbose_name='部门编号，外键', help_text='请选择部门')
    titleId = models.ForeignKey('SysTitle', on_delete=models.CASCADE, db_column='title_id', verbose_name='职位编号，外键', help_text='请输入职位')
    userRealName = models.CharField(db_column='user_realname', max_length=32, unique=True, null=False, blank=False, verbose_name='用户真实姓名', help_text='请输入用户真实姓名')
    userLoginName = models.CharField(db_column='user_login_name', max_length=32, unique=True, null=False, blank=False, verbose_name='用户登录名', help_text='请输入用户登录名')
    userPwd = models.CharField(db_column='user_pwd', max_length=64, null=False, blank=False, verbose_name='用户密码', help_text='请输入用户密码')
    
    
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    name = models.CharField(max_length=32)
    token = models.CharField(u'token', max_length=128,default=None,blank=True,null=True)
    department = models.CharField(u'部门', max_length=32,default=None,blank=True,null=True)
    #business_unit = models.ManyToManyField(BusinessUnit)
    tel = models.CharField(u'座机', max_length=32,default=None,blank=True,null=True)
    mobile = models.CharField(u'手机', max_length=32,default=None,blank=True,null=True)

    memo = models.TextField(u'备注', blank=True,null=True,default=None)
    date_joined = models.DateTimeField(blank=True, auto_now_add=True)
    #valid_begin = models.DateTimeField(blank=True, auto_now=True)
    valid_begin_time = models.DateTimeField(default=timezone.now)
    valid_end_time = models.DateTimeField(blank=True,null=True)

    groups = models.ManyToManyField



    USERNAME_FIELD = 'email'
    #REQUIRED_FIELDS = ['name','token','department','tel','mobile','memo']
    REQUIRED_FIELDS = ['name']

    def get_full_name(self):
        # The user is identified by their email address
        return self.email

    def get_short_name(self):
        # The user is identified by their email address
        return self.email

    def __str__(self):              # __unicode__ on Python 2
        return self.email

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
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin

    class Meta:    
        db_table = 'sys_user' 
        verbose_name = u'用户信息'
        verbose_name_plural = u"用户信息"
    def __unicode__(self):
        return self.name

#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: menu model
'''


from django.db import models

from account.entity.SysMenu import SysMenu
from account.entity.SysRole import SysRole


BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class SysRoleMenu(models.Model):

    roleId = models.ForeignKey(SysRole, 
        on_delete=models.CASCADE,
        db_column='role_id',
        db_index=False,
        verbose_name='角色id，外键',
        help_text='角色id',
    )
    
    menuId = models.ForeignKey(SysMenu,
        on_delete=models.CASCADE,
        db_column='menu_id',
        db_index=False,
        verbose_name='菜单id，外键',
        help_text='菜单id',
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

    REQUIRED_FIELDS = ['roleId', 'menuId', 'isDel', ]

    def __str__(self):              # __unicode__ on Python 2
        return '<RoleID:%s, MenuID:%s>' %(self.roleId, self.menuId)

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
        db_table = 'sys_role_menu' 
        verbose_name = u'角色菜单关联表'
        verbose_name_plural = u"角色菜单关联表"
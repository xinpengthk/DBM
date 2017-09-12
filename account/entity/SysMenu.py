#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: menu model
'''


from django.db import models

BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

MENU_STATUS_CHOICES = (
    (0, '不可用'),
    (1, '可用'),
)

MENU_PRIV_CHOICES = (
    ('C', 'CREATE'),
    ('R', 'READ'),
    ('U', 'UPDATE'),
    ('D', 'DELETE'),
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class SysMenu(models.Model):

    menuId = models.BigAutoField(db_column='menu_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )

    menuParentId = models.ForeignKey('SysMenu', 
        on_delete=models.CASCADE,
        db_column='menu_parent_id',
        verbose_name='菜单父id，外键',
        help_text='菜单父id',
    )

    menuName = models.CharField(db_column='menu_name',
        max_length=32,
        unique=True,
        null=False,
        blank=False,
        verbose_name='菜单名称',
        help_text='请输入菜单名称',
    )

    menuUrl = models.CharField(db_column='menu_url',
        max_length=256,
        null=False,
        blank=False,
        verbose_name='菜单名称',
        help_text='请输入菜单名称',
    )

    menuPriv = models.CharField(db_column='menu_priv',
        max_length=32,
        choice=MENU_PRIV_CHOICES,
        null=False,
        blank=False,
        verbose_name='菜单权限，CRUD...',
        help_text='请输入菜单权限，CRUD...',
    )
    
    menuSort = models.SmallIntegerField(db_column='menu_sort',
        null=False,
        blank=False,
        default=1,
        verbose_name='菜单排序',
        help_text='菜单排序',
    )
    
    menuStatus = models.SmallIntegerField(db_column='menu_status',
        null=False,
        blank=False,
        choices=MENU_STATUS_CHOICES,
        default=1,
        verbose_name='菜单状态，0：不可用，1：可用',
        help_text='菜单状态，0：不可用，1：可用',
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
        return '<menuName:%s, menuUrl:%s, menuPriv:%s>' %(self.menuName, self.menuUrl, self.menuPriv)

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
        db_table = 'sys_menu' 
        verbose_name = u'系统菜单表'
        verbose_name_plural = u"系统菜单表"
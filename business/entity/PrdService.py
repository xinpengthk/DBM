#!/usr/bin/env python
#coding:utf-8

'''
Created on 2017-09-08

@Author: XinPeng
@Description: product service model
'''


from django.db import models

from business.entity.PrdProduct import PrdProduct
from account.entity.SysUser import SysUser


BOOLEAN_CHOICES = (
    (0, '否'),
    (1, '是'),
)

SERVICE_STATUS_CHOICES = (
    (0, '未上线'),
    (1, '已上线'),
    (2, '已下线'),  
)

IS_DEL_CHOICES = (
    (0, '未删除'),
    (1, '已删除'),
)

class PrdService(models.Model):
    serviceId = models.BigAutoField(db_column='service_id', 
        primary_key=True, 
        verbose_name='主键ID', 
        help_text='主键自增ID',
    )

    productId = models.ForeignKey(
        PrdProduct,
        on_delete=models.DO_NOTHING,
        db_column='product_id',
        related_name='product_id',
        db_index=False,
        verbose_name='产品线编号，外键',
        help_text='请选择产品线',
        
    )
    
    serviceName = models.CharField(db_column='service_name',
        max_length=32,
        null=False,
        blank=False,
        db_index=True,
        verbose_name='服务名称',
        help_text='请输入服务名称！',
    )
    
    servicePdm = models.ForeignKey(
        SysUser,
        on_delete=models.DO_NOTHING,
        db_column='service_pdm',
        related_name='servicePdm',
        db_index=False,
        verbose_name='该服务项目经理id，外键, sys_user',
        help_text='请选择项目经理！',
        
    )

    servicePjm = models.ForeignKey(
        SysUser,
        on_delete=models.DO_NOTHING,
        db_column='service_pjm',
        related_name='servicePjm',
        db_index=False,
        verbose_name='该服务产品经理id，外键, sys_user',
        help_text='请选择产品经理！',
        
    )
    
    serviceDevLedear = models.ForeignKey(
        SysUser,
        on_delete=models.DO_NOTHING,
        db_column='service_dev_ledear',
        related_name='serviceDevLedear',
        db_index=False,
        verbose_name='该服务开发ledear，外键, sys_user',
        help_text='请选择该服务开发ledear！',
        
    )
    
    serviceQaLedear = models.ForeignKey(
        SysUser,
        on_delete=models.DO_NOTHING,
        db_column='service_qa_ledear',
        related_name='serviceQaLedear',
        db_index=False,
        verbose_name='该服务测试ledear，外键, sys_user',
        help_text='请选择该服务测试ledear！',
        
    )
    
    serviceStatus = models.SmallIntegerField(db_column='service_status',
        null=False,
        blank=False,
        choices=SERVICE_STATUS_CHOICES,
        default=1,
        verbose_name='服务状态，0：未上线，1：已上线，2：已下线',
        help_text='服务状态，0：未上线，1：已上线，2：已下线',
    )
    
    serviceDesc = models.EmailField(db_column='service_desc',
         max_length=128,
         null=False,
         blank=False,
         verbose_name='服务描述',
         help_text='服务描述！',
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

    REQUIRED_FIELDS = ['productId', 'serviceName', 'servicePdm', 'servicePjm', 'serviceDevLedear', 'serviceQaLedear', 'serviceStatus', 'serviceDesc']

    def __str__(self):              # __unicode__ on Python 2
        return '<Product:%s-Service:%s>' %(self.productId, self.serviceName)

    def get_service_name(self):
        # The user is identified by their email address
        return self.serviceName

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
        db_table = 'prd_service' 
        verbose_name = u'产品线中服务表'
        verbose_name_plural = u"产品线中服务表"
        

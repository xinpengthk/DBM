from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField

from account.entity.SysDept import SysDept
from account.entity.SysTitle import SysTitle
from account.entity.SysUser import SysUser


admin.site.register(SysDept)
admin.site.register(SysTitle)
admin.site.register(SysUser)


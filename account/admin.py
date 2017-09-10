from django.contrib import admin
from account.entity.SysUser import SysUser
from account.entity.SysDept import SysDept
from account.entity.SysTitle import SysTitle


admin.site.register(SysDept)
admin.site.register(SysTitle)
admin.site.register(SysUser)


# -*- coding: utf-8 -*-
# Generated by Django 1.10.8 on 2017-09-17 11:56
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='SysDept',
            fields=[
                ('deptId', models.BigAutoField(db_column='dept_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('deptName', models.CharField(db_column='dept_name', help_text='请输入部门名称', max_length=32, unique=True, verbose_name='部门名称')),
                ('deptLoc', models.CharField(db_column='dept_loc', default='北京', help_text='请输入部门工作地点', max_length=32, verbose_name='部门工作地点')),
                ('deptStatus', models.SmallIntegerField(choices=[(0, '未激活'), (1, '激活')], db_column='dept_status', default=1, help_text='部门激活状态，0：未激活，1：激活', verbose_name='部门激活状态')),
                ('deptDesc', models.CharField(db_column='dept_desc', help_text='请输入部门描述！', max_length=128, verbose_name='部门描述')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
            ],
            options={
                'verbose_name': '系统部门表',
                'verbose_name_plural': '系统部门表',
                'db_table': 'sys_dept',
            },
        ),
        migrations.CreateModel(
            name='SysGroup',
            fields=[
                ('groupId', models.BigAutoField(db_column='group_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('groupName', models.CharField(db_column='group_name', help_text='请输入项目组名称!', max_length=32, unique=True, verbose_name='项目组名称（项目名）')),
                ('groupStatus', models.SmallIntegerField(choices=[(0, '不可用'), (1, '可用')], db_column='group_status', default=1, help_text='项目组状态，0：不可用，1：可用', verbose_name='项目组状态')),
                ('groupDesc', models.CharField(db_column='group_desc', help_text='项目组描述！', max_length=128, verbose_name='项目组描述')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
            ],
            options={
                'verbose_name': '员工分组表',
                'verbose_name_plural': '员工分组表',
                'db_table': 'sys_group',
            },
        ),
        migrations.CreateModel(
            name='SysGroupRole',
            fields=[
                ('groupRoleId', models.BigAutoField(db_column='group_role_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
            ],
            options={
                'verbose_name': '用户角色关联表',
                'verbose_name_plural': '用户角色关联表',
                'db_table': 'sys_group_role',
            },
        ),
        migrations.CreateModel(
            name='SysGroupService',
            fields=[
                ('groupServiceId', models.BigAutoField(db_column='group_service_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
                ('groupId', models.ForeignKey(db_index=False, help_text='用户组 ID', on_delete=django.db.models.deletion.CASCADE, to='account.SysGroup', verbose_name='用户组 ID')),
            ],
            options={
                'verbose_name': '用户服务关联表',
                'verbose_name_plural': '用户服务关联表',
                'db_table': 'sys_group_service',
            },
        ),
        migrations.CreateModel(
            name='SysMenu',
            fields=[
                ('menuId', models.BigAutoField(db_column='menu_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('menuName', models.CharField(db_column='menu_name', help_text='请输入菜单名称', max_length=32, unique=True, verbose_name='菜单名称')),
                ('menuUrl', models.CharField(db_column='menu_url', help_text='请输入菜单名称', max_length=256, verbose_name='菜单名称')),
                ('menuPriv', models.CharField(choices=[('C', 'CREATE'), ('R', 'READ'), ('U', 'UPDATE'), ('D', 'DELETE')], db_column='menu_priv', help_text='请输入菜单权限，CRUD...', max_length=32, verbose_name='菜单权限，CRUD...')),
                ('menuSort', models.SmallIntegerField(db_column='menu_sort', default=1, help_text='菜单排序', verbose_name='菜单排序')),
                ('menuStatus', models.SmallIntegerField(choices=[(0, '不可用'), (1, '可用')], db_column='menu_status', default=1, help_text='菜单状态，0：不可用，1：可用', verbose_name='菜单状态，0：不可用，1：可用')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
                ('menuParentId', models.ForeignKey(db_column='menu_parent_id', help_text='菜单父id', on_delete=django.db.models.deletion.CASCADE, to='account.SysMenu', verbose_name='菜单父id，外键')),
            ],
            options={
                'verbose_name': '系统菜单表',
                'verbose_name_plural': '系统菜单表',
                'db_table': 'sys_menu',
            },
        ),
        migrations.CreateModel(
            name='SysRole',
            fields=[
                ('roleId', models.BigAutoField(db_column='role_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('roleName', models.CharField(db_column='role_name', help_text='请输入角色名称', max_length=32, unique=True, verbose_name='角色名称，唯一')),
                ('roleStatus', models.SmallIntegerField(choices=[(0, '不可用'), (1, '可用')], db_column='role_status', default=1, help_text='角色状态，0：不可用，1：可用', verbose_name='角色状态，0：不可用，1：可用')),
                ('roleDesc', models.CharField(db_column='role_desc', help_text='请输入角色描述', max_length=128, verbose_name='角色描述')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
            ],
            options={
                'verbose_name': '系统角色表',
                'verbose_name_plural': '系统角色表',
                'db_table': 'sys_role',
            },
        ),
        migrations.CreateModel(
            name='SysRoleMenu',
            fields=[
                ('roleMenuId', models.BigAutoField(db_column='role_menu_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
                ('menuId', models.ForeignKey(db_column='menu_id', db_index=False, help_text='菜单id', on_delete=django.db.models.deletion.CASCADE, to='account.SysMenu', verbose_name='菜单id，外键')),
                ('roleId', models.ForeignKey(db_column='role_id', db_index=False, help_text='角色id', on_delete=django.db.models.deletion.CASCADE, to='account.SysRole', verbose_name='角色id，外键')),
            ],
            options={
                'verbose_name': '角色菜单关联表',
                'verbose_name_plural': '角色菜单关联表',
                'db_table': 'sys_role_menu',
            },
        ),
        migrations.CreateModel(
            name='SysTitle',
            fields=[
                ('titleId', models.BigAutoField(db_column='title_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('titleName', models.CharField(db_column='title_name', help_text='请输入岗位名称', max_length=32, unique=True, verbose_name='岗位名称')),
                ('titleType', models.SmallIntegerField(choices=[(100, '普通员工'), (101, '项目ledear'), (102, '部门负责人'), (103, 'XXO'), (104, '临时用户')], db_column='title_type', help_text='岗位类型，100:普通员工，101:项目ledear，102:部门负责人，103:XXO，104:临时用户', verbose_name='岗位类型')),
                ('titleStatus', models.SmallIntegerField(choices=[(0, '未激活'), (1, '激活')], db_column='title_status', default=1, help_text='岗位激活状态，0：未激活，1：激活', verbose_name='岗位激活状态')),
                ('titleDesc', models.CharField(db_column='title_desc', help_text='请输入岗位描述！', max_length=128, verbose_name='岗位描述')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
            ],
            options={
                'verbose_name': '系统岗位表',
                'verbose_name_plural': '系统岗位表',
                'db_table': 'sys_title',
            },
        ),
        migrations.CreateModel(
            name='SysUser',
            fields=[
                ('userId', models.BigAutoField(db_column='user_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('userName', models.CharField(db_column='user_name', help_text='请输入用户姓名', max_length=32, unique=True, verbose_name='用户姓名')),
                ('userPwd', models.CharField(db_column='user_pwd', help_text='请输入用户密码', max_length=64, verbose_name='用户密码')),
                ('userRole', models.SmallIntegerField(choices=[(0, '否'), (1, '是')], db_column='user_role', default=0, help_text='是否为项目leader，1：是，0：否', verbose_name='是否为项目leader')),
                ('userStatus', models.SmallIntegerField(choices=[(0, '未激活'), (1, '激活')], db_column='user_status', default=1, help_text='用户激活状态，0：未激活，1：激活', verbose_name='用户激活状态')),
                ('userEmail', models.EmailField(db_column='user_email', default='xxx@dycd.com', help_text='请输入邮箱！', max_length=128, unique=True, verbose_name='用户邮箱')),
                ('userPhone', models.CharField(db_column='user_phone', default='11000000000', help_text='请输入手机号！', max_length=11, unique=True, verbose_name='用户手机号')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
                ('deptId', models.ForeignKey(db_column='dept_id', db_index=False, help_text='请选择部门！', on_delete=django.db.models.deletion.CASCADE, to='account.SysDept', verbose_name='所属部门')),
                ('titleId', models.ForeignKey(db_column='title_id', db_index=False, help_text='请选择职位！', on_delete=django.db.models.deletion.CASCADE, to='account.SysTitle', verbose_name='所属岗位')),
            ],
            options={
                'verbose_name': '用户信息',
                'verbose_name_plural': '用户信息',
                'db_table': 'sys_user',
            },
        ),
        migrations.CreateModel(
            name='SysUserGroup',
            fields=[
                ('userGroupId', models.BigAutoField(db_column='user_group_id', help_text='主键自增ID', primary_key=True, serialize=False, verbose_name='主键ID')),
                ('isDel', models.SmallIntegerField(choices=[(0, '未删除'), (1, '已删除')], db_column='is_del', default=0, help_text='该记录是否被删除，0：未删除，1：已删除，默认为0', verbose_name='该记录是否被删除')),
                ('createdTime', models.DateTimeField(auto_now_add=True, db_column='created_time', help_text='该记录创建时间', null=True, verbose_name='记录创建时间')),
                ('updatedTime', models.DateTimeField(auto_now=True, db_column='updated_time', help_text='记录最后更新时间', null=True, verbose_name='记录最后更新时间')),
                ('groupId', models.ForeignKey(db_column='group_id', db_index=False, help_text='请选择用户组！ ', on_delete=django.db.models.deletion.CASCADE, to='account.SysGroup', verbose_name='用户组 ')),
                ('userId', models.ForeignKey(db_column='user_id', db_index=False, help_text='请选择用户 ！', on_delete=django.db.models.deletion.CASCADE, to='account.SysUser', verbose_name='用户')),
            ],
            options={
                'verbose_name': '员工项目组关联表',
                'verbose_name_plural': '员工项目组关联表',
                'db_table': 'sys_user_group',
            },
        ),
    ]

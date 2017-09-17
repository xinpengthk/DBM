# -*- coding: utf-8 -*-
# Generated by Django 1.10.8 on 2017-09-17 12:27
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0002_auto_20170917_1156'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sysmenu',
            name='menuUrl',
            field=models.URLField(db_column='menu_url', help_text='请输入菜单名称', max_length=256, verbose_name='菜单名称'),
        ),
    ]

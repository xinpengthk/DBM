from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField

from business.entity.PrdService import PrdService
from business.entity.PrdBusiness import PrdBusiness
from business.entity.PrdProduct import PrdProduct


admin.site.register(PrdBusiness)
admin.site.register(PrdProduct)
admin.site.register(PrdService)

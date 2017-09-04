#!/usr/bin/env python
#-*-coding:utf-8-*-

'''
Created on 2017年8月17日

@Author: xin peng
@Description: 
'''

from django import forms
from metam.entity import Product

class ProductModelForm(forms.ModelForm):

    class Meta:
        model = Product.Product
        fields = ('productName','productStatus', 'productDesc')
        
        widgets = {
            'productDesc' : forms.Textarea,
        }
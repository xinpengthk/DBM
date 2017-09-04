from django.contrib import admin
from metam.entity import Product, MasterConfig

# Register your models here.
admin.site.register(Product.Product)

admin.site.register(MasterConfig.MasterConfig)
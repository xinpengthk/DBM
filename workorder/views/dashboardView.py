from django.shortcuts import render

# Create your views here.

def menuPage(request):
    
    return render(request,'html/base/menu.html')

def dashboard(request):
#     return render(request,'html/base/dashboard.html')
     return render(request,'html/base/table_base.html')  
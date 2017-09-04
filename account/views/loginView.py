from django.shortcuts import render

# Create your views here.

def acc_login(request):
    
    return render(request,'html/account/login.html')
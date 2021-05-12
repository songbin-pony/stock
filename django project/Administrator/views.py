from django.shortcuts import render
from Administrator.models import AdminUser
from django.http import HttpResponse, JsonResponse
import json
from django.db.models import Q
# Create your views here.
def adminadd(request):
    adminname = request.POST.get('params_1')
    password = request.POST.get('params_2')

    try:
        # 在数据库中设置id字段递增，否则不能成功
        newadmin = AdminUser.objects.create(adminname=adminname, password=password)
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})



def adminlogin(request):
    qs = AdminUser.objects.values()
    adminname = request.POST.get('params_1')
    if id:
        qs = qs.filter(adminname=adminname)
    return HttpResponse(json.dumps(list(qs)))

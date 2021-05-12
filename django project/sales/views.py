from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from sales.models import Customer
import json
from django.db.models import Q


# Create your views here.
def listorders(request):
    return HttpResponse('下面是系统中的订单信息')


def listcustomers(request):
    # 返回一个 QuerySet 对象 ，包含所有的表记录
    # 每条表记录都是是一个dict对象，
    # key 是字段名，value 是 字段值
    qs = Customer.objects.values()
    print(request.method)
    ph = request.POST.get('params_1')
    print(ph)
    if ph:
        qs = qs.filter(Q(name__contains=ph) | Q(phonenumber__contains=ph))

    data = json.dumps(list(qs))

    return HttpResponse(data)


def delcustomer(request):
    customerid = request.POST.get('params_1')
    print(customerid)

    try:
        # 根据 id 从数据库中找到相应的客户记录
        customer = Customer.objects.get(id=customerid)
        customer.delete()
    except Customer.DoesNotExist:
        return JsonResponse({'ret': 'false'})

    # delete 方法就将该记录从数据库中删除了

    return JsonResponse({'ret': 'success'})


def findcustomerbyid(request):
    qs = Customer.objects.values()
    id = request.POST.get('params_1')
    print(id)
    if id:
        qs = qs.filter(id=id)

    data = json.dumps(list(qs))

    return HttpResponse(data)


def updatecustomer(request):
    customerid = request.POST.get('params_1[id]')
    customername = request.POST.get('params_1[name]')
    customerphonenumber = request.POST.get('params_1[phonenumber]')
    customeraddress = request.POST.get('params_1[address]')

    try:
        # 根据 id 从数据库中找到相应的客户记录
        customer = Customer.objects.get(id=customerid)
        customer.name = customername
        customer.phonenumber = customerphonenumber
        customer.address = customeraddress
        customer.save()
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})
def addcustomer(request):
    customername = request.POST.get('params_1[name]')
    customerphonenumber = request.POST.get('params_1[phonenumber]')
    customeraddress = request.POST.get('params_1[address]')

    try:
        # 在数据库中设置id字段递增，否则不能成功
        customer = Customer.objects.create(name=customername,phonenumber=customerphonenumber,address=customeraddress)
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})

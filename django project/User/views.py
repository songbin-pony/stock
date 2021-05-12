from django.shortcuts import render
import json
from django.http import HttpResponse, JsonResponse
from User.models import CommonUser
from django.db.models import Q


# Create your views here.
def login(request):
    qs = CommonUser.objects.values()
    username = request.POST.get('params_1')
    print(username)
    if username:
        qs = qs.filter(username=username)

    data = json.dumps(list(qs))

    return HttpResponse(data)


def adduser(request):
    username = request.POST.get('params_1')
    password = request.POST.get('params_2')

    try:
        # 在数据库中设置id字段递增，否则不能成功
        customer = CommonUser.objects.create(username=username, password=password)
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})


def findcommonuser(request):
    qs = CommonUser.objects.values()
    return HttpResponse(json.dumps(list(qs)))


def resetuser(request):
    username = request.POST.get('params_1')
    try:
        user = CommonUser.objects.get(username=username)
        user.password = '123'
        user.save()
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})
    return JsonResponse({'ret': 'success'})


def deleteuser(request):
    username = request.POST.get('params_1')
    try:
        user = CommonUser.objects.get(username=username)
        user.delete()
    except CommonUser.DoesNotExist:
        return JsonResponse({'ret': 'false'})
    return JsonResponse({'ret': 'success'})

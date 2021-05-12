from django.shortcuts import render
from banner.models import Banner
from django.http import HttpResponse, JsonResponse
import json
from django.db.models import Q


# Create your views here.
def findAll(request):
    banners = Banner.objects.values()
    return HttpResponse(json.dumps(list(banners)))


def addBanner(request):
    description = request.POST.get('params_1')
    link = request.POST.get('params_2')

    try:
        # 在数据库中设置id字段递增，否则不能成功
        banner = Banner.objects.create(description=description, link=link)
    except Exception as r:
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})


def updateBanner(request):
    id = request.POST.get('params_1')
    description = request.POST.get('params_2')
    link = request.POST.get('params_3')
    try:
        banner = Banner.objects.get(id=id)
        banner.description = description
        banner.link = link
        banner.save()
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})
    return JsonResponse({'ret': 'success'})


def findBannerbyid(request):
    banner = Banner.objects.values()
    id = request.POST.get('params_1')
    if id:
        qs = banner.filter(id=id)
    return HttpResponse(json.dumps(list(qs)))


def deleteBanner(request):
    id = request.POST.get('params_1')
    try:
        banner = Banner.objects.get(id=id)
        banner.delete()
    except Banner.DoesNotExist:
        return JsonResponse({'ret': 'false'})
    return JsonResponse({'ret': 'success'})

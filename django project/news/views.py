from django.shortcuts import render
from news.models import news
from django.http import HttpResponse, JsonResponse
import json
import datetime

# Create your views here.
def saveNews(request):
    newstitle = request.POST.get('params_1')
    newscontent = request.POST.get('params_2')
    nowtime = datetime.datetime.now()
    nowtime_str = nowtime.strftime("%Y%m%d%H%M%S")
    try:
        news.objects.create(newstitle=newstitle, newscontent=newscontent,newsdate=nowtime_str)
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})


def findNews(request):
    allnews = news.objects.values()
    return HttpResponse(json.dumps(list(allnews)))


def deleteNews(request):
    id = request.POST.get('params_1')
    try:
        to_delnews = news.objects.get(id=id)
        to_delnews.delete()
    except news.DoesNotExist:
        return JsonResponse({'ret': 'false'})
    return JsonResponse({'ret': 'success'})


def findNewsbyid(request):
    id = request.POST.get('params_1')
    # 如下写是无效的
    # to_edit_news = news.objects.get(id=id).values()
    to_edit_news = news.objects.values().filter(id=id)
    return HttpResponse(json.dumps(list(to_edit_news)))


def updateNews(request):
    newsid = request.POST.get('params_1')
    newstitle= request.POST.get('params_2')
    newscontent = request.POST.get('params_3')
    nowtime = datetime.datetime.now()
    nowtime_str = nowtime.strftime("%Y%m%d%H%M%S")

    try:
        # 根据 id 从数据库中找到相应的客户记录
        to_update_news = news.objects.get(id=newsid)
        to_update_news.newstitle= newstitle
        to_update_news.newscontent = newscontent
        to_update_news.newsdate = nowtime_str
        to_update_news.save()
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})
    return JsonResponse({'ret': 'success'})


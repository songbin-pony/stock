from django.shortcuts import render
from history.function import dayinfofunc, weekinfofunc, monthinfofunc,moneyflowfunc
from django.http import HttpResponse, JsonResponse


# Create your views here.
def dayinfo(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = dayinfofunc(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


def weekinfo(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = weekinfofunc(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


def monthinfo(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = monthinfofunc(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)

def moneyflow(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = moneyflowfunc(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


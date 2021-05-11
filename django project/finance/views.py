from django.shortcuts import render
from finance.function import financeinfo_1_func,financeinfo_2_func,financeinfo_3_func,financeinfo_4_func,financeinfo_5_func
from django.http import HttpResponse, JsonResponse

# Create your views here.
def financeinfo_1(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = financeinfo_1_func(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


def financeinfo_2(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = financeinfo_2_func(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


def financeinfo_3(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = financeinfo_3_func(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


def financeinfo_4(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = financeinfo_4_func(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)


def financeinfo_5(request):
    tscode = request.POST.get('params_1')
    starttime = request.POST.get('params_2')
    endtime = request.POST.get('params_3')
    print(tscode, starttime, endtime)
    qs = financeinfo_5_func(tscode, starttime, endtime)
    print(qs)
    return HttpResponse(qs)
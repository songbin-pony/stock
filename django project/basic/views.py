from django.shortcuts import render
from basic.function import basicinfofunc, manageinfofunc, manageholdinfofunc
from django.http import HttpResponse, JsonResponse


# Create your views here.
def basicinfo(request):
    tscode = request.POST.get('params_1')
    print(tscode)
    qs = basicinfofunc(tscode)
    print(qs)
    return HttpResponse(qs)


def manageinfo(request):
    tscode = request.POST.get('params_1')
    print(tscode)
    qs = manageinfofunc(tscode)
    print(qs)
    return HttpResponse(qs)


def manageholdinfo(request):
    tscode = request.POST.get('params_1')
    print(tscode)
    qs = manageholdinfofunc(tscode)
    print(qs)
    return HttpResponse(qs)

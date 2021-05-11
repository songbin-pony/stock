from django.shortcuts import render
import json
from django.http import HttpResponse, JsonResponse
from StockList.models import Stock
from User.models import CommonUser
from django.db.models import Q
import datetime
from StockList.generatedata import getstockprice
from StockList.forecast import forecastfunc


# Create your views here.
def findAllStock(request):
    qs = Stock.objects.values()

    data = json.dumps(list(qs))

    return HttpResponse(data)


def findBySymbolAndName(request):
    username = request.POST.get('params_1')
    symbol = request.POST.get('params_2')
    print(username, symbol)
    a = Stock.objects.values()
    stock = Stock.objects.get(symbol=symbol)
    # Stock.objects.values() 是 <QuerySet [{'id': 1, 'industry': '银行', 'tscode': '000001.SZ', 'symbol': '000001', 'name': '平安银行', 'listdate': '19910403', 'area': '深圳'}, {'id': 2, 'industry': '全国地产', 'tscode': '000002.SZ', 'symbol': '000002', 'name': '万科A', 'listdate': '19910129', 'area': '深圳'},]>
    # Stock.objects.get(symbol=symbol) 是 <class 'StockList.models.Stock'>
    # stock.commonuser.all() 是 <QuerySet [<CommonUser: CommonUser object (2)>, <CommonUser: CommonUser object (3)>]>
    # stock.commonuser.all().values() 是 <QuerySet [{'username': 'hc', 'id': 2, 'password': '123456'},
    # {'username': 'hechen', 'id': 3, 'password': 'hechen123456'}]>
    # stock.commonuser.values() 是 <QuerySet [{'password': '123456', 'username': 'hc', 'id': 2}, {'password': 'hechen123456', 'username': 'hechen', 'id': 3}]>
    # stock.commonuser.filter(username=username) 是 <QuerySet [<CommonUser: CommonUser object (2)>]>
    # Stock.objects 是 StockList.Stock.objects
    # Stock.objects.all() 是 <QuerySet [<Stock: Stock object (1)>, <Stock: Stock object (2)>,...]>
    qs = stock.commonuser.filter(username=username).values()
    return HttpResponse(json.dumps(list(qs)))


def Addstock(request):
    username = request.POST.get('params_1')
    symbol = request.POST.get('params_2')
    try:
        # 在数据库中设置id字段递增，否则不能成功
        stock = Stock.objects.get(symbol=symbol)
        commonuser = CommonUser.objects.get(username=username)
        stock.commonuser.add(commonuser)
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})


def findMystock(request):
    username = request.POST.get('params_1')
    print(username)
    commonuser = CommonUser.objects.get(username=username)
    qs = commonuser.stock_set.all().values()
    return HttpResponse(json.dumps(list(qs)))


def Delstock(request):
    username = request.POST.get('params_1')
    symbol = request.POST.get('params_2')
    try:
        stock = Stock.objects.get(symbol=symbol)
        commonuser = CommonUser.objects.get(username=username)
        commonuser.stock_set.remove(stock)
    except Exception as r:
        print(r)
        return JsonResponse({'ret': 'false'})

    return JsonResponse({'ret': 'success'})


def searchByNameOrSymbol_1(request):
    username = request.POST.get('params_1')
    searchcontent = request.POST.get('params_2')
    print(username, searchcontent)
    commonuser = CommonUser.objects.get(username=username)
    qs = commonuser.stock_set.filter(Q(name__contains=searchcontent) | Q(symbol__contains=searchcontent)).values()
    return HttpResponse(json.dumps(list(qs)))


def searchByNameOrSymbol_2(request):
    searchcontent = request.POST.get('params_1')
    print(searchcontent)
    qs = Stock.objects.filter(Q(name__contains=searchcontent) | Q(symbol__contains=searchcontent)).values()
    return HttpResponse(json.dumps(list(qs)))


def predict_data(request):
    username = request.POST.get('params_1')
    commonuser = CommonUser.objects.get(username=username)
    qs = commonuser.stock_set.all().values('tscode')
    qr = commonuser.stock_set.all().values('tscode', 'name')
    ts_code_list = []
    for item in qs:
        ts_code_list.append(item['tscode'])
    print(ts_code_list)
    # 准备时间
    tom_time = datetime.datetime.now() + datetime.timedelta(days=-1)
    ago_time = datetime.datetime.now() + datetime.timedelta(days=-31)
    ago_str = ago_time.strftime("%Y%m%d")
    tom_str = tom_time.strftime("%Y%m%d")
    # 获得30天内的股票收盘价
    stockdata = getstockprice(ts_code_list, ago_str, tom_str)
    print(stockdata)
    return HttpResponse(json.dumps(stockdata))


def predict_list(request):
    username = request.POST.get('params_1')
    commonuser = CommonUser.objects.get(username=username)
    qr = commonuser.stock_set.all().values('tscode', 'name')
    return HttpResponse(json.dumps(list(qr)))


def predict_result(request):
    username = request.POST.get('params_1')
    commonuser = CommonUser.objects.get(username=username)
    qs = commonuser.stock_set.all().values('tscode')
    ts_code_list = []
    for item in qs:
        ts_code_list.append(item['tscode'])
    print(ts_code_list)
    predict_result = predictstock(ts_code_list)
    print('预测结果', predict_result)
    return HttpResponse(json.dumps(predict_result))


def predictstock(ts_code_list):
    curr_time = datetime.datetime.now()
    curr_str = curr_time.strftime("%Y%m%d")
    resultdict = {}
    for item in ts_code_list:
        stock = Stock.objects.get(tscode=item)
        stock_predictdate = stock.predictdate
        print(stock_predictdate)
        if stock_predictdate != curr_str:
            print(item, '使用已预测数据')
            result = forecastfunc(item)
            resultdict[item] = str(result)
            stock.predictdate = curr_str
            stock.predictprice = result
            stock.save()
        else:
            print(item, '需要预测')
            result = stock.predictprice
            print(result)
            resultdict[item] = str(result)
    return resultdict

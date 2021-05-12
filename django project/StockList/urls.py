from django.urls import path
from StockList.views import findAllStock, findBySymbolAndName, Addstock, findMystock, Delstock, searchByNameOrSymbol_1
from StockList.views import searchByNameOrSymbol_2, predict_data, predict_result, predict_list

urlpatterns = [
    path('findAllStock/', findAllStock),
    path('findBySymbolAndName/', findBySymbolAndName),
    path('Addstock/', Addstock),
    path('findMystock/', findMystock),
    path('Delstock/', Delstock),
    path('searchByNameOrSymbol_1/', searchByNameOrSymbol_1),
    path('searchByNameOrSymbol_2/', searchByNameOrSymbol_2),
    path('predict_data/', predict_data),
    path('predict_result/', predict_result),
    path('predict_list/', predict_list),

]

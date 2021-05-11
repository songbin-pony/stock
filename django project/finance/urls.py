from django.urls import path
from finance.views import financeinfo_1, financeinfo_2, financeinfo_3,financeinfo_4,financeinfo_5

urlpatterns = [
    path('financeinfo_1/', financeinfo_1),
    path('financeinfo_2/', financeinfo_2),
    path('financeinfo_3/', financeinfo_3),
    path('financeinfo_4/', financeinfo_4),
    path('financeinfo_5/', financeinfo_5),
]

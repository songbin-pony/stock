from django.urls import path
from history.views import dayinfo, weekinfo, monthinfo, moneyflow

urlpatterns = [
    path('dayinfo/', dayinfo),
    path('weekinfo/', weekinfo),
    path('monthinfo/', monthinfo),
    path('moneyflow/', moneyflow),

]

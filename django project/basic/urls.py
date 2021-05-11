from django.urls import path
from basic.views import basicinfo, manageinfo, manageholdinfo

urlpatterns = [
    path('basicinfo/', basicinfo),
    path('manageinfo/', manageinfo),
    path('manageholdinfo/', manageholdinfo),

]

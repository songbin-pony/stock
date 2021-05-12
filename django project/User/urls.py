from django.urls import path
from User.views import login, adduser,findcommonuser,resetuser,deleteuser

urlpatterns = [
    path('login/', login),
    path('adduser/', adduser),
    path('findcommonuser/', findcommonuser),
    path('resetuser/', resetuser),
    path('deleteuser/', deleteuser),

]

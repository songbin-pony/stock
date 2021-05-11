from django.urls import path
from User.views import login, adduser

urlpatterns = [
    path('login/', login),
    path('adduser/', adduser),

]

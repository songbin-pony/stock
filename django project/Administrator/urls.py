from django.urls import path
from Administrator.views import adminlogin, adminadd

urlpatterns = [
    path('adminlogin/', adminlogin),
    path('adminadd/', adminadd),
]

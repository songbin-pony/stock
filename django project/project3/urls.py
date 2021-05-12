"""project3 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from django.conf.urls import url
from project3 import settings
from django.views.static import serve

urlpatterns = [
    path('admin/', admin.site.urls),
    path('sales/', include('sales.urls')),
    path('user/', include('User.urls')),
    path('stock/', include('StockList.urls')),
    path('history/', include('history.urls')),
    path('basic/', include('basic.urls')),
    path('finance/', include('finance.urls')),
    path('administrator/', include('Administrator.urls')),
    path('banner/', include('banner.urls')),
    path('upload/', include('upload.urls')),
    path('news/', include('news.urls')),
    url(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}),
]


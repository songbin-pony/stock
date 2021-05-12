from django.urls import path
from banner.views import findAll,addBanner,updateBanner,findBannerbyid,deleteBanner

urlpatterns = [
    path('findall/', findAll),
    path('addbanner/', addBanner),
    path('updatebanner/',updateBanner),
    path('findbannerbyid/',findBannerbyid),
    path('deletebanner/',deleteBanner)
]

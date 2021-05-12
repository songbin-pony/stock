from django.urls import path
from news.views import saveNews,findNews,deleteNews,findNewsbyid,updateNews

urlpatterns = [
    path('savenews/', saveNews),
    path('findnews/', findNews),
    path('deletenews/', deleteNews),
    path('findnewsbyid/', findNewsbyid),
    path('updatenews/', updateNews),
]

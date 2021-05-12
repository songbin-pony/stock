from django.urls import path
from upload.views import uploadimg

urlpatterns = [
    path('uploadimg/', uploadimg),

]

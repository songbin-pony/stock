from django.shortcuts import render
import os
import datetime
from django.http import HttpResponse, JsonResponse
import json
from upload.models import Picture
# Create your views here.
def uploadimg(request):
    imgfile = request.FILES.get("upload")  # 拿到文件对象
    nowtime = datetime.datetime.now()
    nowtime_str = nowtime.strftime("%Y%m%d%H%M%S")+imgfile.name[-4:]
    imgfile.name=nowtime_str
    picture=Picture(picturecontent=imgfile)
    picture.save()
    response = {
        "uploaded": True,
        "filename": imgfile.name,
        "url": 'http://127.0.0.1:8000/media/img/' + imgfile.name
    }

    return HttpResponse(json.dumps(response))

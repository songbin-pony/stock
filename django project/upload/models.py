from django.db import models


# Create your models here.
class Picture(models.Model):
    picturecontent = models.FileField(upload_to='img')

from django.db import models
from User.models import CommonUser


# Create your models here.
class Stock(models.Model):
    tscode = models.CharField(max_length=200)
    symbol = models.CharField(max_length=200)
    name = models.CharField(max_length=200)
    area = models.CharField(max_length=200)
    industry = models.CharField(max_length=200)
    listdate = models.CharField(max_length=200)
    predictdate = models.CharField(max_length=200,default='abc')
    predictprice = models.CharField(max_length=200,default='abc')
    commonuser = models.ManyToManyField(CommonUser)
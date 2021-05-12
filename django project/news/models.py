from django.db import models

# Create your models here.
from django.db import models
from User.models import CommonUser


# Create your models here.
class news(models.Model):
    newstitle = models.CharField(max_length=200)
    newscontent = models.CharField(max_length=2000)
    newsdate=models.CharField(max_length=200)


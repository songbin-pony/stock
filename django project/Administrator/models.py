from django.db import models

# Create your models here.
class AdminUser(models.Model):
    adminname = models.CharField(max_length=200)

    password = models.CharField(max_length=200)

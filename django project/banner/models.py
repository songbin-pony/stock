from django.db import models

# Create your models here.
from django.db import models

# Create your models here.
class Banner(models.Model):
    description = models.CharField(max_length=200)

    link = models.CharField(max_length=200)

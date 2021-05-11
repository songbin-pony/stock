from django.urls import path
from sales.views import listorders,listcustomers,delcustomer,findcustomerbyid,updatecustomer,addcustomer
urlpatterns = [
    path('orders/',listorders),
    path('customers/', listcustomers),
    path('delcustomer/', delcustomer),
    path('findcustomerbyid/', findcustomerbyid),
    path('updatecustomer/', updatecustomer),
    path('addcustomer/', addcustomer),

]
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('list/', views.list, name='list'),
    path('write/', views.write, name='write'),
    path('write_ok/', views.write_ok, name='write_ok'),
    path('del', views.delete, name='delete'),
]
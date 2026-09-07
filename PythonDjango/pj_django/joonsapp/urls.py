from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('list/', views.list, name='list'),
    path('write/', views.write, name='write'),
    path('write/write_ok/', views.write_ok, name='write_ok'),
    path('delete/<int:id>', views.delete, name='delete'),
    path('update/<int:id>', views.update, name='update'),
    path('update/update_ok/<int:id>', views.update_ok, name='update_ok'),
    path('login/', views.login, name = 'login'),
    path('login/login_ok/', views.login_ok, name='login_ok'),
    path('logout/', views.logout, name = 'logout'),
    path('join/', views.join, name='join'),
    path('check_email/', views.check_email, name='check_email'),

    path('template1/', views.test1, name='template1'),
    path('template2/', views.test2, name='template2'),
    path('template3/', views.test3, name='template3'),

    path('board/list/', views.blist, name='board_list'),
    path('board/content/<int:id>/', views.bcontent, name='board_content'),
    path('board/write/', views.bwrite, name='board_write'),
    path('board/write/write_ok/', views.bwrite_ok, name='board_write_ok'),
    path('board/update/<int:id>/', views.bupdate, name='board_update'),
    path('board/update/update_ok/<int:id>/', views.bupdate_ok, name='board_update_ok'),
    path('board/delete/<int:id>/', views.bdelete, name='board_delete'),

    path('upload/', views.upload, name='upload'),
    path('upload/upload_ok/', views.upload_ok, name='upload_ok'),
    path('upload/list/', views.upload_list, name='upload_list'),
    path('upload/delete/<int:id>/', views.upload_delete, name='upload_delete'),
    path('chart/', views.chart, name='chart'),
    path('chart/chart_data/', views.chart_data, name='chart_data'),
    path('chart/chart_data2/', views.chart_data2, name='chart_data2'),
    ]

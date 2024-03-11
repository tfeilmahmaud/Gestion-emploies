from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path

from . import views

urlpatterns = [
    path('department', views.departmentApi),
    path('department/<int:id>', views.departmentApi),

    path('employee', views.employeeApi),
    path('employee/<int:id>', views.employeeApi),

    path('employee/savefile', views.SaveFile),
    path('register/', views.register),
    path('login/', views.LoginView),
    path('user', views.info),   
    path('logout/', views.LogoutView)
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

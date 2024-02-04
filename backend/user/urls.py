# yourapp/urls.py
from django.urls import path
from .views import SignUpView, SignInView, ProfileView, LogoutView

urlpatterns = [
    path('signup/', SignUpView.as_view(), name='signup'),
    path('signin/', SignInView.as_view(), name='signin'),
    path('profile/', ProfileView.as_view(), name='profile'),
    path('logout/', LogoutView.as_view(), name='logout'),  # Add the logout URL
]

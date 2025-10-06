from django.urls import include, path
from rest_framework.routers import DefaultRouter

from api import views

router = DefaultRouter()
router.register(r"users", views.UserViewSet)
router.register(r"todolists", views.TodoListViewSet)
router.register(r"todos", views.TodoViewSet)

app_name = "api"
urlpatterns = [
    path("", include(router.urls)),
    # ДОДАНО: Шляхи для Kubernetes Probes
    path("readiness/", views.readiness_check, name="readiness"),
    path("liveness/", views.liveness_check, name="liveness"),
]

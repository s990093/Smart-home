# chat/routing.py
from django.urls import re_path

from . import consumers
from .senor_consuers import SensorConsumer

websocket_urlpatterns = [
    re_path(r"ws/chat/(?P<room_name>\w+)/$", consumers.ChatConsumer.as_asgi()),
    re_path(r"ws/sensor/(?P<room_name>\w+)/$", SensorConsumer.as_asgi()),
]
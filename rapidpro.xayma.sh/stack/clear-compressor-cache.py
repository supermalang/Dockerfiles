import redis
import os
from getenv import env
from urllib.parse import urlparse
from django.conf import settings
from django.core.cache import cache

settings.configure()

key_prefix = cache.make_key('django_compressor')

REDIS_HOST = os.environ.get('REDIS_HOST', 'localhost')
REDIS_PORT = os.environ.get('REDIS_PORT', 6379)

redis_host = REDIS_HOST
redis_port = REDIS_PORT
redis_db = 15

redis = redis.Redis(host=redis_host, port=redis_port, db=redis_db)
keys = redis.keys('%s.*' % (key_prefix,))
for key in keys:
    redis.delete(key)
    print('Cleared Django Compressor key: %s' % (key,))

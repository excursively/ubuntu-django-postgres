from .base import *

# static files
STATIC_URL = '/static/'
STATIC_ROOT = '/home/web/static'
MEDIA_ROOT = '/home/web/media'

# database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),
        'PASSWORD': os.environ.get('DB_PASSWORD'),
        'HOST': os.environ.get('DB_HOST'),
        'PORT': os.environ.get('DB_PORT', 5432),
        'ATOMIC_REQUESTS': True,
    }
}



##############################################################################
# SYSTEM GENERATED CODE, DO NOT REMOVE AND KEEP IT AT THE BUTTOM OF THE FILE #
##############################################################################
try:
    import uwsgi
    from uwsgidecorators import timer
    from django.utils import autoreload

    @timer(3)
    def change_code_gracefull_reload(sig):
        if autoreload.code_changed():
            uwsgi.reload()
except:
    print('application did not start by uwsgi, ignoring autoreload..')

##############################################################################

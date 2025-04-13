# Deployment Guide for Plant Identifier Application

This guide provides instructions for deploying the Django Plant Identifier application to a production environment.

## Prerequisites

- A server or hosting platform (e.g., AWS, DigitalOcean, Heroku, PythonAnywhere)
- Domain name (optional)
- Basic knowledge of server administration
- SSH access to your server (for traditional deployment)

## Option 1: Traditional Deployment (VPS/Dedicated Server)

### 1. Server Setup

1. Set up a server with Ubuntu/Debian/CentOS
2. Install required packages:
   ```bash
   sudo apt update
   sudo apt install python3 python3-pip python3-venv nginx
   ```

### 2. Clone or Upload Your Project

```bash
git clone https://github.com/yourusername/django-plant-identifier.git
# OR upload your project files via SFTP
```

### 3. Set Up Virtual Environment and Install Dependencies

```bash
cd django-plant-identifier
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip install gunicorn  # For production server
```

### 4. Configure Django for Production

Create a production settings file `plant_identifier/production_settings.py`:

```python
from .settings import *

DEBUG = False
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com', 'your-server-ip']

# Use a stronger secret key in production
SECRET_KEY = 'your-strong-secret-key'

# Configure database (optional, if using a different database in production)
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'plant_identifier_db',
        'USER': 'db_user',
        'PASSWORD': 'db_password',
        'HOST': 'localhost',
        'PORT': '',
    }
}

# Static files configuration
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

# Media files configuration
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'
```

### 5. Set Up Gunicorn

Create a systemd service file `/etc/systemd/system/plant-identifier.service`:

```
[Unit]
Description=Plant Identifier Gunicorn Daemon
After=network.target

[Service]
User=yourusername
Group=www-data
WorkingDirectory=/path/to/django-plant-identifier
ExecStart=/path/to/django-plant-identifier/venv/bin/gunicorn --workers 3 --bind unix:/path/to/django-plant-identifier/plant_identifier.sock plant_identifier.wsgi:application --env DJANGO_SETTINGS_MODULE=plant_identifier.production_settings

[Install]
WantedBy=multi-user.target
```

Enable and start the service:
```bash
sudo systemctl enable plant-identifier
sudo systemctl start plant-identifier
```

### 6. Configure Nginx

Create an Nginx configuration file `/etc/nginx/sites-available/plant-identifier`:

```
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    
    location /static/ {
        root /path/to/django-plant-identifier;
    }
    
    location /media/ {
        root /path/to/django-plant-identifier;
    }
    
    location / {
        include proxy_params;
        proxy_pass http://unix:/path/to/django-plant-identifier/plant_identifier.sock;
    }
}
```

Enable the site and restart Nginx:
```bash
sudo ln -s /etc/nginx/sites-available/plant-identifier /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

### 7. Set Up SSL (Recommended)

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

## Option 2: Deployment on PythonAnywhere

PythonAnywhere is a simple hosting platform for Python applications.

1. Sign up for a PythonAnywhere account
2. Upload your code or clone from GitHub
3. Set up a virtual environment and install dependencies
4. Configure a web app with the following settings:
   - Framework: Django
   - Python version: 3.8 or higher
   - Path to your project's wsgi.py file
   - Working directory: your project directory
5. Configure static files and media files in the Web tab
6. Update your settings.py file for production

## Option 3: Deployment on Heroku

1. Install the Heroku CLI
2. Create a `Procfile` in your project root:
   ```
   web: gunicorn plant_identifier.wsgi --log-file -
   ```
3. Create a `runtime.txt` file:
   ```
   python-3.9.7
   ```
4. Install additional requirements:
   ```bash
   pip install gunicorn dj-database-url psycopg2-binary whitenoise
   pip freeze > requirements.txt
   ```
5. Update settings.py for Heroku:
   ```python
   import dj_database_url
   
   # Add whitenoise middleware
   MIDDLEWARE = [
       'whitenoise.middleware.WhiteNoiseMiddleware',
       # ... other middleware
   ]
   
   # Static files
   STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
   STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
   
   # Database configuration
   db_from_env = dj_database_url.config(conn_max_age=500)
   DATABASES['default'].update(db_from_env)
   
   # Allow Heroku host
   ALLOWED_HOSTS = ['your-app-name.herokuapp.com', 'localhost', '127.0.0.1']
   ```
6. Deploy to Heroku:
   ```bash
   git init
   git add .
   git commit -m "Initial commit for Heroku"
   heroku create your-app-name
   git push heroku master
   heroku run python manage.py migrate
   heroku run python manage.py createsuperuser
   ```

## Security Considerations

1. Keep `DEBUG = False` in production
2. Use a strong, unique `SECRET_KEY`
3. Regularly update dependencies
4. Use HTTPS (SSL/TLS)
5. Implement proper authentication and authorization
6. Regularly backup your database
7. Set up proper logging
8. Consider using environment variables for sensitive information

## Maintenance

1. Set up regular backups
2. Monitor server performance
3. Update dependencies regularly
4. Set up error monitoring (e.g., Sentry)
5. Implement a CI/CD pipeline for smooth updates

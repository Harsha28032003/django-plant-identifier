# Plant Identifier - Django Application

This is a Django-based plant identification application that uses the PlantNet API to identify plants from uploaded images.

## Prerequisites

Before you begin, ensure you have the following installed:

- Python 3.8 or higher
- pip (Python package manager)
- Git (optional, for cloning the repository)

## Setup Instructions

Follow these steps to set up and run the project:

### 1. Clone or Download the Repository

```bash
git clone <repository-url>
# or download and extract the ZIP file
```

### 2. Create a Virtual Environment (Recommended)

```bash
# Navigate to the project directory
cd django_plant_identifier

# Create a virtual environment
python -m venv venv

# Activate the virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

If the requirements.txt file is not available, install the following packages:

```bash
pip install django
pip install requests
pip install pillow
```

### 4. Configure the Database

```bash
python manage.py migrate
```

### 5. Create a Superuser (Admin)

```bash
python manage.py createsuperuser
```

Follow the prompts to create an admin user.

### 6. Configure Media Directory

Ensure the media directory exists for storing uploaded images:

```bash
mkdir -p media/plants
```

### 7. Run the Development Server

```bash
python manage.py runserver
```

The application will be available at http://127.0.0.1:8000/

### 8. Access the Application

- Open your web browser and navigate to http://127.0.0.1:8000/
- Log in with the superuser credentials you created
- You can now upload plant images for identification

## API Configuration

This application uses the PlantNet API for plant identification. The API key is already configured in the application, but if you need to use your own API key:

1. Get an API key from [PlantNet](https://my.plantnet.org/)
2. Open `plants/views.py` and update the `API_KEY` variable with your key

## Project Structure

- `plant_identifier/` - Main Django project settings
- `plants/` - Django app for plant identification
- `templates/` - HTML templates
- `static/` - Static files (CSS, JavaScript)
- `media/` - User-uploaded files

## Features

- User authentication (login/register)
- Plant image upload
- Plant identification using PlantNet API
- Display of plant details including:
  - Scientific name
  - Common names
  - Family and genus
  - Identification confidence score

## Troubleshooting

### Common Issues

1. **Database Errors**: If you encounter database errors, try:
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

2. **Media Files Not Displaying**: Ensure your `MEDIA_URL` and `MEDIA_ROOT` are correctly configured in `settings.py`.

3. **API Connection Issues**: Check your internet connection and verify the API key is correct.

### Getting Help

If you encounter any issues not covered here, please contact the project maintainer.

## License

[Include your license information here]

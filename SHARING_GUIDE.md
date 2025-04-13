# Sharing Your Plant Identifier Application

This guide provides instructions on how to share your Django Plant Identifier application with others.

## Preparing the Project for Sharing

Before sharing your project, make sure you have:

1. Added all necessary files to the project
2. Created a README.md file with setup instructions
3. Created a requirements.txt file with all dependencies
4. Added setup scripts for easy installation

All of these have already been prepared for you.

## Sharing Options

### Option 1: Share the Code Directory

You can simply zip the entire `django_plant_identifier` directory and share it with others. They can then follow the instructions in the README.md file to set up the project.

#### Steps to create a ZIP file:

**On Windows:**
1. Right-click on the `django_plant_identifier` folder
2. Select "Send to" > "Compressed (zipped) folder"

**On macOS:**
1. Right-click on the `django_plant_identifier` folder
2. Select "Compress django_plant_identifier"

**On Linux:**
```bash
zip -r django_plant_identifier.zip django_plant_identifier
```

### Option 2: Share via Version Control (e.g., GitHub)

If you want to share your project via GitHub or another version control system:

1. Create a new repository on GitHub
2. Initialize Git in your project folder (if not already done):
   ```bash
   cd django_plant_identifier
   git init
   ```
3. Add all files to Git:
   ```bash
   git add .
   ```
4. Commit the files:
   ```bash
   git commit -m "Initial commit"
   ```
5. Add your GitHub repository as a remote:
   ```bash
   git remote add origin https://github.com/yourusername/django-plant-identifier.git
   ```
6. Push your code to GitHub:
   ```bash
   git push -u origin master
   ```
7. Share the repository URL with others

## Instructions for Recipients

When sharing your project, make sure to tell recipients to:

1. Read the README.md file for detailed setup instructions
2. Run the appropriate setup script for their operating system:
   - Windows: `setup.bat`
   - macOS/Linux: `./setup.sh`
3. Create a superuser account after setup:
   ```bash
   python manage.py createsuperuser
   ```
4. Start the development server:
   ```bash
   python manage.py runserver
   ```
5. Access the application at http://127.0.0.1:8000/

## Troubleshooting Common Issues

Here are some common issues recipients might encounter and how to solve them:

### 1. Python Not Installed

Recipients need to have Python 3.8 or higher installed. They can download it from [python.org](https://www.python.org/downloads/).

### 2. Permission Issues with setup.sh

If recipients encounter permission issues with the setup.sh script on macOS/Linux, they should run:
```bash
chmod +x setup.sh
```

### 3. Database Migration Issues

If there are issues with database migrations, recipients can try:
```bash
python manage.py makemigrations
python manage.py migrate
```

### 4. Media Directory Issues

If uploaded images are not being saved or displayed, recipients should check that the media directory exists:
```bash
mkdir -p media/plants
```

## Additional Resources

- [Django Documentation](https://docs.djangoproject.com/)
- [PlantNet API Documentation](https://my.plantnet.org/doc)
- [Python Virtual Environments Guide](https://docs.python.org/3/tutorial/venv.html)

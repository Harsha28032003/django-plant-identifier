#!/bin/bash

echo "Django Plant Identifier - Setup Script"
echo "====================================="
echo

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# Activate virtual environment and install dependencies
echo "Activating virtual environment and installing dependencies..."
source venv/bin/activate
pip install -r requirements.txt

# Set up database
echo "Setting up database..."
python manage.py migrate

# Create media directories
echo "Creating media directories..."
mkdir -p media/plants

echo
echo "Setup completed successfully!"
echo
echo "To run the server:"
echo "source venv/bin/activate"
echo "python manage.py runserver"
echo
echo "Access the application at: http://127.0.0.1:8000/"

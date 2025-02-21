# Use the official Python image as the base image
FROM python:3

# Install required packages
RUN apt-get update && apt-get install -y python3-distutils

# Install Django
RUN pip install django==3.2

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of the application code
COPY . .

# Run database migrations
RUN python manage.py migrate

# Expose the port that the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]




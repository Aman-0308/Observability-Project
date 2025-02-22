# Use the official Python image as the base image
FROM python:3

# Install required packages
RUN apt-get update && apt-get install -y python3-distutils python3-setuptools python3-pip

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run database migrations
RUN python3 manage.py migrate

# Expose the port that the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]




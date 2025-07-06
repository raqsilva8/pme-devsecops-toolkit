FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Accept SECRET_KEY as build-arg and set as env for build step
ARG SECRET_KEY
ENV SECRET_KEY=${SECRET_KEY}
RUN cd app && python manage.py collectstatic --noinput

# Run the application
CMD ["gunicorn", "--chdir", "app", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]

# Sử dụng Python base image
FROM python:3.11-slim

# Cài đặt Java cho tabula-py
RUN apt-get update && \
    apt-get install -y default-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements và cài đặt dependencies
COPY ConverterApp/requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ code
COPY . .

# Expose port
EXPOSE $PORT

# Start command
WORKDIR /app/ConverterApp
CMD gunicorn pdftoexcel:app --bind 0.0.0.0:$PORT --workers 2 --threads 2 --timeout 120


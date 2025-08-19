FROM python:3.11-slim

# i set working directory
WORKDIR /app

# now install Python dependncies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# to copy service code
COPY ./services /app/services

# i ensure PYTHONPATH includes /app for imports
ENV PYTHONPATH=/app

# did expose FastAPI port
EXPOSE 8000

# and run fastapi app with Uvicorn
CMD ["uvicorn", "services.data_loader.main:app", "--host", "0.0.0.0", "--port", "8000"]
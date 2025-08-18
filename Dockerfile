FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./services /app/services

ENV PYTHONPATH=/app

CMD ["uvicorn", "services.data_loader.main:app", "--host", "0.0.0.0", "--port", "8000"]
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    OUTPUT_DIR=/app/artifacts

WORKDIR /app

COPY requirements.lock.txt .
RUN pip install --no-cache-dir --disable-pip-version-check -r requirements.lock.txt

COPY train_azerbaijan.py qualifying_grid.example.json azerbaijan_predictions.json ./
COPY tests ./tests

CMD ["python", "train_azerbaijan.py"]

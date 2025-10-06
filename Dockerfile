FROM python:3.8

# Ставимо системні залежності для коректної збірки та для curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl \
    && rm -rf /var/lib/apt/lists/*

# Небуферизований вивід для логування
ENV PYTHONUNBUFFERED 1

# Встановлюємо робочу диреторію
WORKDIR /app

# Копіюємо файл залежностей (з кореня проєкту)
COPY requirements.txt .

# Встановлюємо залежності
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо увесь код
COPY . .

# Відкриваємо порт 8080 
EXPOSE 8080

# Запуск: міграції + сервер на порту 8080
CMD ["sh", "-c", "python src/manage.py migrate --noinput && python src/manage.py runserver 0.0.0.0:8080"]
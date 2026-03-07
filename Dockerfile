FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y curl && apt-get install zstd && rm -rf /var/lib/apt/list/*
RUN curl -fsSL https://ollama.com/install.sh | sh
COPY app.py embed.py k8s.txt ./
RUN pip install fastapi uvicorn chromadb ollama
RUN python embed.py
EXPOSE 8080
CMD sh -c "ollama serve & sleep 5 && ollama pull tinyllama && uvicorn app:app --host 0.0.0.0 --port 8080"

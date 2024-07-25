FROM python:3.9-slim
WORKDIR /app
COPY requirments.txt /app/requirments.txt
RUN pip install --upgrade pip
RUN pip install -r requirments.txt

COPY . .
CMD [ "python", "-m" , "flask", "run", "--host=0.0.0.0"]
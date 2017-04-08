FROM python:2.7-alpine
ARG EXPOSE_PORT=8000
LABEL SERVICE_${EXPOSE_PORT}_CHECK_TCP=true
COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE $EXPOSE_PORT

ENTRYPOINT ["python"]
CMD ["app.py"]

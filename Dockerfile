FROM python:3.9-alpine3.13
LABEL maintainer="pythunity.com"

#we want to prevent python logs in the console 
ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /requirements.txt
COPY ./app /app
COPY ./scripts /scripts

#cd
WORKDIR /app
EXPOSE 8000

# Recomanded to run this cmds in one RUN to prevent docker to create multiple layer
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \ 
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app && \
    # recomanded to run the conatainer with a simple user because by default the user is the root (copromise the app )
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts
    
ENV PATH="/scripts:/py/bin:$PATH"

#switch to the user app
# USER app

CMD ["run.sh"]






FROM alpine:3.3
MAINTAINER think@hotmail.de

RUN \
  apk add --no-cache python3 && \
  apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
  wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 && \
  apk del build-dependencies

RUN pip install --no-cache-dir pyaml

COPY bin /bin
COPY compose_format /usr/local/lib/python3.5/site-packages/compose_format
COPY ["features/*.feature", "Dockerfile", "README.md", "/"]

RUN chmod +x /bin/compose_format

ENTRYPOINT ["python3", "/bin/compose_format"]

ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}

USER root

# Install python app requirements
COPY requirements.txt /
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

COPY entrypoint.sh /

ENTRYPOINT ["./entrypoint.sh"]
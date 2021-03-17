FROM ubuntu:16.04

# set the variables as per $(pyenv init -)
ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
	  POETRY_HOME="/opt/poetry" \
    PATH="/opt/poetry/bin:/opt/pyenv/shims:/opt/pyenv/bin:$PATH" \
    PYENV_ROOT="/opt/pyenv" \
    PYENV_SHELL="bash" \
		PYTHON_VERSION="3.7.4"
	
RUN apt-get update && \
	  apt-get install -y build-essential \
		checkinstall \
		libreadline-gplv2-dev \
		libncursesw5-dev \
		libssl-dev \
		libsqlite3-dev \
		tk-dev \
		libgdbm-dev \
		libc6-dev \
		libbz2-dev \
		zip \
		unzip \
		zlib1g-dev \
		openssl \
		libffi-dev \
		python3-dev \
		python3-setuptools \
		curl \
		openjdk-8-jdk\
		openjdk-8-jre-headless\
		git && \
		apt-get clean

RUN curl https://pyenv.run | bash

RUN pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
    && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
    && rm -rf /tmp/*

RUN pip install -U pip

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

RUN chmod +x /opt/poetry/bin/poetry

RUN curl 'https://archive.apache.org/dist/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz' --output /tmp/spark-2.4.7-bin-hadoop2.7.tgz && \
    cd / && \
		tar -xvzf /tmp/spark-2.4.7-bin-hadoop2.7.tgz && \
		rm /tmp/spark-2.4.7-bin-hadoop2.7.tgz && \
		mv spark-2.4.7-bin-hadoop2.7 spark

ENV SPARK_HOME=/spark \
		JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ENV PATH=$SPARK_HOME/bin:$PATH




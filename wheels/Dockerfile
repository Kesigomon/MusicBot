FROM python:3.7-buster
WORKDIR /opt
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
WORKDIR /opt
COPY requirements.txt .
COPY wheels /tmp/wheels
RUN  mkdir wheels \
    && pip install wheel \
    && LIBSODIUM_MAKE_ARGS=-j4 pip wheel --find-links /tmp/wheels -r requirements.txt -w wheels
CMD ["/bin/bash"]
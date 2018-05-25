FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip python3-numpy python3-setuptools libopenblas-dev python3-lxml libjpeg-dev ffmpeg

RUN pip3 install --no-cache-dir --upgrade pip numpy setuptools pyasn1-modules
RUN pip install --no-cache-dir tensorflow==1.5
RUN pip install --no-cache-dir luminoth

RUN useradd -m -d /app luminoth

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

EXPOSE 5000

USER luminoth

WORKDIR /app

RUN /usr/local/bin/lumi checkpoint refresh
RUN /usr/local/bin/lumi checkpoint download fast

CMD /usr/local/bin/lumi server web --host 0.0.0.0 --port 5000 --debug --checkpoint fast

FROM resin/rpi-raspbian:jessie

RUN apt-get update -qy && apt-get install -qy \
    build-essential \
    python \
    python-rpi.gpio \
    python-psutil \
    gcc \
    python-pip \
    python-blinkt \
    python3-blinkt

# Cancel out any Entrypoint already set in the base image.
ENTRYPOINT []	

WORKDIR /root/
RUN mkdir /root/examples
COPY cpu_load.py	examples
RUN pip install dumb-init

WORKDIR /root/examples/
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/root/examples/cpu_load.py"]
CMD ["python", "/root/examples/cpu_load.py"]

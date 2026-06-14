FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    python3 \
    python3-pip \
    make \
    git \
    iverilog \
    verilator \
    gtkwave \
    yosys

RUN pip3 install --break-system-packages \
    cocotb \
    pytest

WORKDIR /workspace

CMD ["bash"]
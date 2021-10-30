FROM nvcr.io/nvidia/pytorch:21.10-py3

RUN apt-get update \
  && apt-get install -y wget git python3 python3-pip

ARG USER_ID
ARG GROUP_ID
ARG USER
RUN addgroup --gid $GROUP_ID $USER
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

RUN pip3 install -U wheel pip pandas tqdm nibabel wget

# Clone and compile nitorch
RUN git clone https://github.com/balbasty/nitorch.git \
  && cd nitorch \
  && git reset --hard d30c3125a8a66ea1434f2b39ed03338afd9724b4 \
  && NI_COMPILED_BACKEND="C" ./setup.py bdist_wheel \
  && cd dist/ \
  && pip install nitorch-0.1+100.gd30c312-cp38-cp38-linux_x86_64.whl --no-dependencies

# Install unires and download atlas
RUN pip3 install git+https://github.com/brudfors/UniRes@fdeee7bb6778fec582847e02de8bac7ff2899dbd \
  && python3 -c "from nitorch.core.datasets import fetch_data; fetch_data('atlas_t1')"
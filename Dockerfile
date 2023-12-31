FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel
LABEL maintainer="Jonghyun An"
LABEL repository="prml"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
        apt install -y bash \
                build-essential \
                wget \
                vim \
                git \
                git-lfs \
                curl \
                ca-certificates \
                libsndfile1-dev \
                libgl1 \
                python3.8 \
                python3-pip \
                python3.8-venv && \
        rm -rf /var/lib/apt/lists

# pre-install the heavy dependencies (these can later be overridden by the deps from setup.py)
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
        python3 -m pip install --no-cache-dir \
                torch \
                torchvision \
                torchaudio \
                pytorch-lightning \
                invisible_watermark && \
        python3 -m pip install --no-cache-dir \
                accelerate \
                datasets \
                hf-doc-builder \
                huggingface-hub \
                Jinja2 \
                librosa \
                numpy \
                scipy \
                spacy \
                matplotlib \
                tensorboard \
                transformers \
                omegaconf \
                sentencepiece \
                safetensors \
                diffusers \
                xformers

CMD ["/bin/bash"]

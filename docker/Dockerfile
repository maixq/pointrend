
# Specify base image which can be pulled from a container registry
FROM 763104351884.dkr.ecr.ap-southeast-1.amazonaws.com/pytorch-training:1.13.1-gpu-py39-cu117-ubuntu20.04-ec2

# Install linux packages
RUN apt update &&\
    apt install -y libgl1-mesa-glx libglib2.0-0 \
    libsm6 libxrender1 libxext6

# Install dependencies
COPY ./docker/requirements.txt requirements.txt
RUN pip install -r requirements.txt &&\
    # Install Detectron2
    pip install 'git+https://github.com/facebookresearch/fvcore' &&\
    pip install 'git+https://github.com/facebookresearch/detectron2.git'

# This will by default build detectron2 for all common cuda architectures and take a lot more time,
# because inside `docker build`, there is no way to tell which architecture will be used.
ARG TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}" \
    # set FORCE_CUDA because during `docker build` cuda is not accessible
    FORCE_CUDA="1" \
    PATH="/pointrend:${PATH}" \
    PYTHONUNBUFFERED=TRUE \
    PYTHONDONTWRITEBYTECODE=TRUE \
    # nvidia-runtime ENV configurations from: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/user guide.html
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility

COPY ./train_net.py /pointrend/train_net.py
COPY ./register_dataset.py /pointrend/register_dataset.py
COPY ./configs /pointrend/configs/

WORKDIR /pointrend
RUN mkdir data/ 

ENTRYPOINT ["python", "train_net.py", "--config-file"]
CMD ["/pointrend/data/dent_run1/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml"]


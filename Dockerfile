FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-devel

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install libsndfile1-dev -y

COPY . ./

RUN pip install dvc boto3 --ignore-installed ruamel.yaml

RUN dvc pull



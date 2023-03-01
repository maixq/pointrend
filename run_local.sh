
IMAGE=carro-cv-training
RUN=dent_run2
MODEL_WEIGHTS=/pointrend/data/$RUN/output/model_final_run3.pth
CONFIG=/pointrend/data/$RUN/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml

docker run \
--interactive \
-v $(pwd)/data:/pointrend/data \
--runtime=nvidia \
--shm-size 8G \
--gpus all \
$IMAGE \
--config-file \
$CONFIG \
# --eval-only \
# MODEL.WEIGHTS $MODEL_WEIGHTS
# --resume
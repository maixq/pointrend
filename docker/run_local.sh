
IMAGE=pointrend
RUN=dent_run1

docker run \
--interactive \
--name pointrend-container \
-v $(pwd)/data:/pointrend/data \
--runtime=nvidia \
--shm-size 8G \
--gpus all \
$IMAGE 
--config-file /pointrend/data/$RUN/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml \
# --eval-only
# --resume
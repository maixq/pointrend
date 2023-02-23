
IMAGE=pointrend

docker run \
--rm \
--interactive \
--shm-size 8G \
--name pointrend-container \
-v $(pwd)/data:/pointrend/data \
--gpus all \
$IMAGE \
--config-file /pointrend/data/dent/run3/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml \
# --eval-only

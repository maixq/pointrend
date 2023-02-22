
IMAGE=pointrend

docker run \
--interactive \
--name pointrend-container \
-v $(pwd)/data:/pointrend/data \
$IMAGE

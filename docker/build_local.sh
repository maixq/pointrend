
# for accessing base image
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 763104351884.dkr.ecr.ap-southeast-1.amazonaws.com

docker build \
--file ./docker/Dockerfile \
--tag pointrend \
. 

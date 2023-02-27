
## Intro
Containarise detectron2 pointrend model for vehicle damage detection. 

## Set Up

The following data directory structure is required to run the scripts.

```
Data
└── dent_run1
    ├── annotations
    │   ├── test.json
    │   ├── train.json
    │   └── val.json
    ├── configs
    │   └── pointrend_rcnn_R_50_FPN_1x_coco.yaml
    ├── images
    │   ├── test
    │   ├── train
    │   └── val
    └── output
        ├── config.yaml
        ├── inference
        ├── last_checkpoint
        ├── log.txt
        ├── metrics.json
        └── model_final.pth
```

The data folder is organised by damage type where each damage type folder contains the different training runs.
Each run folder contains the annotations, images and configs folders needed for the training, and an output folder where the model weights are stored.

1. Modify datasets and output folder based on the name of the run in config file. Fine tune parameters if necessary. 

```
# pointrend/data/dent_run1/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml

# modify custom dataset name to {runname}_train / {runname}_val
DATASETS:
  TRAIN: ("dent_run1_train",)
  TEST: ("dent_run1_val",)
  
# modidfy output dir to ./data/{runname}/output
OUTPUT_DIR: ./data/dent_run1/output

# modify parameters
SOLVER:
    IMS_PER_BATCH: 4
    BASE_LR: 0.001
    STEPS: (800, 15000)
    MAX_ITER: 10
    CHECKPOINT_PERIOD: 5
    
```

2. Change the run name in docker/run_local.sh accordingly. Uncomment --eval-only for evaluation or --resume to resume training from the latest checkpoint.

```
IMAGE=pointrend
CONTAINER_NAME={container_name}
RUN={runname} e.g dent_run1
CONFIG=/pointrend/data/$RUN/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml

docker run \
--interactive \
-v $(pwd)/data:/pointrend/data \
--runtime=nvidia \
--shm-size 8G \
--gpus all \
--config-file \
$CONFIG \
--eval-only \
MODEL.WEIGHTS $MODEL_WEIGHTS
# --resume
```
3. Run docker image to build container 

```
# ./pointrend

bash docker/run_local.sh
```

4. The weights and log file of the model are placed in ./data/{runname}/output



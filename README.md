
## Intro
Containarise detectron2 pointrend model for vehicle damage detection. 

## Set Up

The following data directory structure is required to run the scripts. 

1. Create a data folder. Organise the data folder as shown and set the run name of sub directories as `{type of damage}_{run number}` e.g dent_run1

In each sub directories of data folders:

| Directory name | Description |
| --- | --- |
| configs | config file for fine-tuning and modifying the name of registered data |
| images | images directories for train, val and test |
| annotations | JSON files for train, val and test |
| output | stores model weights, log file of training |

```console
.
├── data
│   └── {type of damage}_{run number} # e.g dent_run1
│       ├── annotations
│       │   ├── test.json
│       │   ├── train.json
│       │   └── val.json
│       ├── configs
│       │   └── pointrend_rcnn_R_50_FPN_1x_coco.yaml
│       ├── images
│       │   ├── test
│       │   ├── train
│       │   └── val
│       └── output
│           ├── config.yaml
│           ├── inference
│           ├── last_checkpoint
│           ├── log.txt
│           ├── metrics.json
│           └── model_final.pth
└── ...
```

2. Modify datasets and output folder based on the name of the run in config file. Fine tune parameters if necessary. 

```console
# pointrend/data/{type of damage}_{run number}/configs/pointrend_rcnn_R_50_FPN_1x_coco.yaml

# modify custom dataset name to {type of damage}_{run number}_train / {type of damage}_{run number}_val
DATASETS:
  TRAIN: ("dent_run1_train",)
  TEST: ("dent_run1_val",)
  
# modify output dir to ./data/{type of damage}_{run number}/output
OUTPUT_DIR: ./data/dent_run1/output

# modify parameters
SOLVER:
    IMS_PER_BATCH: 4
    BASE_LR: 0.001
    STEPS: (800, 15000)
    MAX_ITER: 10
    CHECKPOINT_PERIOD: 5
    
```

2. Change the run name in docker/run_local.sh accordingly. Uncomment `--eval-only` for evaluation or `--resume` to resume training from the latest checkpoint.

```console
IMAGE=pointrend
CONTAINER_NAME={container_name}
RUN={type of damage}_{run number} e.g dent_run1
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

```console
# ./pointrend

bash docker/run_local.sh
```

4. The weights and log file of the model are placed in `./data/{type of damage}_{run number}/output`




from detectron2.data.datasets import register_coco_instances

def register_damage_detection(run):
    DATASET = run
    
    # train
    register_coco_instances(
        "{}_train".format(DATASET),
        {},
        "/pointrend/data/{}/annotations/train.json".format(DATASET),
        "/pointrend/data/{}/images/train/".format(DATASET),
    )
    
    # val
    register_coco_instances(
        "{}_val".format(DATASET),
        {},
        "/pointrend/data/{}/annotations/val.json".format(DATASET),
        "/pointrend/data/{}/images/val/".format(DATASET),
    )
    
    # test
    register_coco_instances(
        "{}_test".format(DATASET),
        {},
        "/pointrend/data/{}/annotations/test.json".format(DATASET),
        "/pointrend/data/{}/images/test/".format(DATASET),
    )

#!/bin/bash

echo "Running script at $(date): $0"
{ 
source activate gnn_env
pip install torch_geometric==2.6.1 dgl==2.1.0 pandas scikit_learn torchvision \
  numpy scipy einops ogb pyyaml googledrivedownloader networkx gdown matplotlib \
  wandb autograd_lib
} &> /dev/null
echo "Setup complete at $(date)"

# export WANDB_API_KEY=
export DIRECTORY=$1
export DATASET=$2
export GNN=$3
EXTRA_ARGS=""
[[ -n "$4" ]] && EXTRA_ARGS="$4"
export JSON_FILE=$DIRECTORY/data/best_hyperparams.json

PROJECT='try'
export CMD="python $DIRECTORY/main.py \
  --device 0 \
  --gnn $GNN \
  --dataset $DATASET \
  --project $PROJECT \
  --project_name ${DATASET}_${GNN} \
  --data_dir $DIRECTORY/data \
  --model_dir $DIRECTORY/model \
  --save_model \
  --info_dir $DIRECTORY/info \
  $EXTRA_ARGS"

bash  $DIRECTORY/run_one.sh
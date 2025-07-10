#!/usr/bin/env python3
import sys
import json
import numpy as np

json_path = sys.argv[1]
with open(json_path, 'r') as f:
    data = json.load(f)

if len(sys.argv) == 2:
    datasets = " ".join(data.keys())
    gnns = " ".join(set(k for d in data.values() for k in d.keys()))
    print(f"DATASETS='{datasets}'")
    print(f"GNNS='{gnns}'")
    print()
    exit(0)

dataset = sys.argv[2]
gnn = sys.argv[3]
if gnn not in data[dataset].keys():
    exit(1)
params = data[dataset][gnn]
print(f"# {dataset} {gnn}")
print(f"DATASET={dataset}")
print(f"GNN={gnn}")
for key in [
    "hidden_channels", "epochs", "lr", "runs", "local_layers", "dropout",
    "metric", "normalization", "residual", "rand_split_class", "valid_num",
    "test_num", "seed", "pre_linear", "weight_decay"
]:
    value = params.get(key)
    if value is True:
        print(f"{key.upper()}=true")
    elif value is False or value is None:
        continue
    else:
        print(f"{key.upper()}={value}")
print()

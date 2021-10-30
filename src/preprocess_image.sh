#!/bin/bash
printf '%s\n' --------------------
echo ARGS
printf '%s\n' --------------------

atlas_rigid=${1}
bids=${2}
crop=${3}
ct=${4}
do_atlas_align=${5}
do_coreg=${6}
do_print=${7}
do_res_origin=${8}
fov=${9}
max_iter=${10}
ids_filename=${11}
pipeline_name=${12}
prefix=${13}
scaling=${14}
start=${15}
stop=${16}
unified_rigid=${17}
vx=${18}

echo atlas_rigid ${atlas_rigid}
echo bids ${bids}
echo crop ${crop}
echo ct ${ct}
echo do_atlas_align ${do_atlas_align}
echo do_coreg ${do_coreg}
echo do_print ${do_print}
echo do_res_origin ${do_res_origin}
echo fov ${fov}
echo max_iter ${max_iter}
echo ids_filename ${ids_filename}
echo pipeline_name ${pipeline_name}
echo prefix ${prefix}
echo scaling ${scaling}
echo start ${start}
echo stop ${stop}
echo unified_rigid ${unified_rigid}
echo vx ${vx}

printf '%s\n' --------------------
echo PYTHON
printf '%s\n' --------------------
python3 /project/src/preprocess_image.py \
  --atlas_rigid ${atlas_rigid} \
  --bids ${bids} \
  --crop ${crop} \
  --ct ${ct} \
  --do_atlas_align ${do_atlas_align} \
  --do_coreg ${do_coreg} \
  --do_print ${do_print} \
  --do_res_origin ${do_res_origin} \
  --fov ${fov} \
  --max_iter ${max_iter} \
  --ids_filename ${ids_filename} \
  --pipeline_name ${pipeline_name} \
  --prefix ${prefix} \
  --scaling ${scaling} \
  --start ${start} \
  --stop ${stop} \
  --unified_rigid ${unified_rigid} \
  --vx ${vx}

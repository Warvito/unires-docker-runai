#!/bin/bash
printf '%s\n' --------------------
echo ARGS
printf '%s\n' --------------------

atlas_rigid=${1}
bids=${2}
common_output=${3}
crop=${4}
ct=${5}
do_atlas_align=${6}
do_coreg=${7}
do_print=${8}
do_res_origin=${9}
fov=${10}
max_iter=${11}
ids_filename=${12}
pipeline_name=${13}
pow=${14}
scaling=${15}
start=${16}
stop=${17}
unified_rigid=${18}
vx=${19}

echo atlas_rigid ${atlas_rigid}
echo bids ${bids}
echo common_output ${common_output}
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
echo scaling ${scaling}
echo pow ${pow}
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
  --common_output ${common_output} \
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
  --pow ${pow} \
  --scaling ${scaling} \
  --start ${start} \
  --stop ${stop} \
  --unified_rigid ${unified_rigid} \
  --vx ${vx}

atlas_rigid=0
bids=0
crop=1
ct=0
do_atlas_align=1
do_coreg=1
do_print=1
do_res_origin=1
fov="head"
max_iter=0
ids_filename="/project/data/adni_subjects.tsv"
pipeline_name="super-res"
prefix=""
scaling=1
unified_rigid=1
vx=1

for i in {0..10}; do
  start=$((${i} * 100))
  stop=$(((${i} + 1) * 100))
  runai submit \
    --name unires-runai-${start}-${stop} \
    --image 10.202.67.207:5000/wds20:clip-image \
    --backoff-limit 0 \
    --gpu 1 \
    --cpu 1 \
    --large-shm \
    --run-as-user \
    --host-ipc \
    --project wds20 \
    --volume /nfs:/nfs \
    --volume /nfs/home/wds20/datasets/NeuroRadKCH/derivatives:/derivatives \
    --volume /nfs/home/wds20/projects/clinical_clip:/project \
    --command -- bash /project/src/preprocess_image.sh \
    ${atlas_rigid} \
    ${bids} \
    ${crop} \
    ${ct} \
    ${do_atlas_align} \
    ${do_coreg} \
    ${do_print} \
    ${do_res_origin} \
    ${fov} \
    ${max_iter} \
    ${ids_filename} \
    ${pipeline_name} \
    ${prefix} \
    ${scaling} \
    ${start} \
    ${stop} \
    ${unified_rigid} \
    ${vx}
done

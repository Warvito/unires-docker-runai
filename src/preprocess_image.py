""" Script to preprocess the images using UniRes.

This script preprocess the list of images indicated in the inputted id list (tsv file).

Based on /dgx1a/nfs/home/mbrudfors/Projects/unires/preproc.py
"""
import argparse
import sys
from pathlib import Path

import nibabel as nib
import pandas as pd
from tqdm import tqdm
from unires.run import preproc
from unires.struct import settings

nib.Nifti1Header.quaternion_threshold = -1e-06


def main(args):
    print("Arguments:")
    for k, v in vars(args).items():
        print(f"  {k}: {v}")

    derivatives_dir = Path("/derivatives/")

    pipeline_dir = derivatives_dir / args.pipeline_name
    pipeline_dir.mkdir(exist_ok=True)

    ids_df = pd.read_csv(args.ids_filename, sep="\t")
    ids_df = ids_df[args.start: args.stop]

    pbar = tqdm(ids_df.iterrows(), total=len(ids_df), file=sys.stdout, disable=False)
    for _, row in pbar:
        img_path = Path(row["path"])
        pbar.set_postfix(
            {
                "image": img_path.stem,
            },
        )

        subject_id = img_path.stem.split("_")[0]
        session_id = img_path.stem.split("_")[1]

        subject_dir = pipeline_dir / subject_id / session_id / "anat"

        if not img_path.is_file():
            print(f"{str(img_path)} do not exists")

        # Check if subject already preprocessed
        if subject_dir.is_dir():
            existing_files = list(subject_dir.glob("*.nii.gz"))
            if len(existing_files) > 0:
                continue

        subject_dir.mkdir(exist_ok=True, parents=True)

        # UniRes
        config = settings()
        config.atlas_rigid = bool(args.atlas_rigid)
        config.bids = bool(args.bids)
        config.crop = bool(args.crop)
        config.ct = bool(args.ct)
        config.dir_out = str(subject_dir)
        config.do_atlas_align = bool(args.do_atlas_align)
        config.do_coreg = bool(args.do_coreg)
        config.do_print = args.do_print
        config.do_res_origin = bool(args.do_res_origin)
        config.fov = args.fov
        config.max_iter = args.max_iter
        config.prefix = args.prefix
        config.scaling = bool(args.scaling)
        config.unified_rigid = bool(args.unified_rigid)
        config.vx = args.vx

        try:
            _ = preproc([str(img_path)], config)
        except Exception as e:
            print("GOT AN ERROR!")
            print(e)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--atlas_rigid",
        type=int,
        default=0,
        help="Rigid or rigid+isotropic scaling alignment to atlas (1=True, 0=False)",
    )
    parser.add_argument(
        "--bids",
        type=int,
        default=0,
        help="For adding a BIDS compatible space tag ('_space-unires_') (1=True, 0=False)",
    )
    parser.add_argument(
        "--crop",
        type=int,
        default=0,
        help="Crop input images' FOV to brain in the NITorch atlas (1=True, 0=False)",
    )
    parser.add_argument(
        "--ct",
        type=int,
        default=0,
        help="Data could be CT (if contain negative values) (1=True, 0=False)",
    )
    parser.add_argument(
        "--do_atlas_align",
        type=int,
        default=0,
        help="Align images to an atlas space (1=True, 0=False)",
    )
    parser.add_argument(
        "--do_coreg",
        type=int,
        default=0,
        help="Coregistration of input images (1=True, 0=False)",
    )
    parser.add_argument(
        "--do_print",
        type=int,
        default=1,
        help="Print progress to terminal (0, 1, 2, 3)",
    )
    parser.add_argument(
        "--do_res_origin",
        type=int,
        default=0,
        help="Resets origin, if CT data (1=True, 0=False)",
    )
    parser.add_argument(
        "--fov",
        type=str,
        default="brain",
        help="If crop=True, uses this field-of-view ('brain'|'head')",
    )
    parser.add_argument(
        "--max_iter",
        type=int,
        default=512,
        help="Max algorithm iterations",
    )
    parser.add_argument(
        "--ids_filename",
        type=str,
        default="/project/data/ids.tsv",
        help="Path to the ids list of the subjects to be processed.",
    )
    parser.add_argument(
        "--pipeline_name",
        type=str,
        default="super-res",
        help="Name of the preprocessing pipeline.",
    )
    parser.add_argument(
        "--prefix",
        type=str,
        default="",
        help="Prefix for reconstructed image(s)"
    )
    parser.add_argument(
        "--scaling",
        type=int,
        default=1,
        help="Optimise even/odd slice scaling (1=True, 0=False)",
    )
    parser.add_argument("--start", type=int, help="Starting index to process.")
    parser.add_argument("--stop", type=int, help="Stopping index to process.")
    parser.add_argument(
        "--unified_rigid",
        type=int,
        default=1,
        help="Do unified rigid registration (1=True, 0=False)",
    )
    parser.add_argument(
        "--vx",
        type=int,
        default=1,
        help="Reconstruction voxel size (use 0 or None to just denoise)",
    )

    args = parser.parse_args()
    main(args)

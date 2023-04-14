#!/usr/bin/env sh

urls=(
  "https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/cam_imu.bag"
  "https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/phone_imu.bag"
  "https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/zed_imu.bag"
  "https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/seq41.bag"
  "https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/seq42.bag"
)

for url in "${urls[@]}"
do
    echo "Downloading ${url}..."
    wget --show-progress "${url}"
done

echo "All downloads complete."

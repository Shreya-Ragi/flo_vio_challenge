## Flo VIO challenge

- To get a working visual odometry solution for a given dataset

### About the dataset
> Note : The datasets provided are in rosbag format
1. [cam_imu.bag](https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/cam_imu.bag) - calibration dataset
3. [phone_imu.bag](https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/phone_imu.bag) - dataset to calibrate imu 
4. [zed_imu.bag](https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/zed_imu.bag) - dataset collected with a zed 2 camera, contains imu data
5. [seq41.bag](https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/seq41.bag) - general dataset containing visual inertial information
6. [seq42.bag](https://inhouse-vision-dataset.s3.ap-south-1.amazonaws.com/seq42.bag) - general dataset containing visual inertial information 

### Instructions:
1. Fork this repo
2. cd into the `data` directory and run `download.sh`
3. Push your solution's source code to your forked repo
4. Append to this README file on how one can run your solution against the dataset
5. Add results (images, plots, videos, etc) in `results` directory

### Important:
[Apriltag info for calibration dataset](https://github.com/ethz-asl/kalibr/wiki/downloads#calibration-targets)
   - Refer the target labelled `Aprilgrid 6x6 0.8x0.8 m (A0 page)`


### Running
 TODO

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

### Running
 
 ## MultiCamera And IMU-Camera Calibration (Zed cam IMU)
 
 1. Create a workspace called calib_ws and navigate into the src folder
 ```bash
 mkdir -p ~/calib_ws/src
 cd calib_ws/src/
 ```
 2. Setup https://github.com/ethz-asl/kalibr (as given in https://github.com/ethz-asl/kalibr/wiki) and https://github.com/ori-drs/allan_variance_ros. After building the workspace, source the workspace in bashrc. 
 4. To generate the allen variance for imu data, create a calibration file `imuconfig.yaml` in `calib_ws/src/allan_variance_ros/config/`:
 ```
 imu_topic: "/imu0/raw"
 imu_rate: 200
 measure_rate: 200 # Rate to which imu data is subsampled
 sequence_time: 24252 # 6 hours in seconds
 ```
 The values are obtained from the `zed_imu.bag` rosbag.
 5. Follow the steps in the allan_variance_ros repository given above [use the zed_imu.bag] Am `imu.yaml` file is generated. Be sure to change the topic name and rate in this file.
 6. To start of with Multicamera calibration, refer to the Kalibr wiki [https://github.com/ethz-asl/kalibr/wiki]. The equired files:
  - bag - cam_imu.bag
  - topics - /zed/zed_node/left_raw/image_raw_color/compressed, /zed/zed_node/right_raw/image_raw_color/compressed
  - model - pinhole-radtan (both)
  - target - april gird (yaml file available in /data directory)
 A camchain.yaml file with intrinsic and extrinsic details of the cameras and ther tranformation is generated.
 7. Calibrate Camera-IMU following the steps for it on the same wiki. Required files:
  - bag - cam_imu.bag
  - cam - camchain.yaml file generated in previous step
  - imu - imu.yaml files generated from allan_variance_ros
  - target - april grid
 A `camchain-imu.yaml` file is generated which has the transforms between both cameras and IMU.
 
 ## Visualizig VIO Output
 
 1. Create a workspace called vins_ws and install OpenVINS following this steps here https://docs.openvins.com/. Source this workspace into bashrc.
 2. Copy the contents of `imu.yaml` and `camchain-imu.yaml` into the `kalibr_imuchain.yaml` and `kalbr_imucamchain.yaml` files in `/config/euroc_mav/`. Change the camera topic name from /zed/zed_node/left_raw/image_raw_color/compresse to /zed/zed_node/left_raw/image_raw_color/decomp. Same with the right camera.
 3. The follow the given steps:
 - In a new terminal run:
 ```bash
 cd ~/flo_vio_challenge/data
 rosbag play --pause seq41.bag
 ```
 Open 2 new terminals and run one of these commads on each:
 ```bash
 rosrun image_transport republish compressed in:=/zed/zed_node/left_raw/image_raw_color raw out:=/zed/zed_node/left_raw/image_raw_color/decomp
 rosrun image_transport republish compressed in:=/zed/zed_node/right_raw/image_raw_color raw out:=/zed/zed_node/right_raw/image_raw_color/decomp
 ```
 This subcribes to the "in" topic which is publishing sensor messages of type compressedImage, decompresse this, and publishes raw images to a new "out" topic.
 In a new terminal run:
 ```bash
 roslaunch ov_msckf subscribe.launch config:=euroc_mav
 ```
 Also run rviz in another terminal to visualize the VIO path.


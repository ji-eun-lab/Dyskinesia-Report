#!/bin/bash

# Step 1: Dyskinesia-Report 디렉토리로 이동
cd "$(dirname "$0")"

# Step 2: SAM2 디렉토리로 이동하고 test.py 실행
echo "Running test.py in sam2 directory..."
cd sam2
python test.py

# Step 3: CycleGAN 디렉토리로 이동하고 data.py 실행
echo "Running data.py in cyclegan directory..."
cd ../cyclegan
python data.py

# Step 4: CycleGAN 모델을 사용한 test.py 실행
echo "Running test.py with CycleGAN model..."
python test.py --dataroot /home/medisc/Dyskinesia-Report/cyclegan/datasets/processed_videos --name mydata_1024 --model cycle_gan --num_test 4200 --direction BtoA

# Step 5: data_final.py 실행
echo "Running data_final.py..."
python data_final.py

# Step 6: Detection 디렉토리로 이동하고 detection.py 실행
echo "Running detection.py in detection directory..."
cd ../detection/detection
python detection.py --input_data_path /home/medisc/Dyskinesia-Report/cyclegan/results/mydata_1024/test_latest/images_rec_A/output_video.mp4 --guide_book_path="configs/mediapipe_pose_guide.json" --mm_model_path="config/weight/pose_landmarker_heavy.task" --detect_model_path="config/weight/mult_label_classifier.pth"

echo "All steps completed."

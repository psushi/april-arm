# AprilArm

**Winner, HuggingFace LeRobot Hackathon 2025 (Top 10%, #24 of 250+ submissions)**

Zero-cost leader arm for SO-100 teleoperation. Uses AprilTag pose estimation with a 3D-printed controller to replace expensive leader-follower setups, cutting hardware costs in half.

*Susheendhar Vijay, Nidhin Ninan, Mohammed Rashad*

## Demo

[1 Min Demo Video](https://github.com/user-attachments/assets/e8480acb-b422-40d0-b512-5118c11b4a0e)

## Cost

| Traditional Setup | AprilArm |
|------------------|----------|
| Leader arm + controller: ~$110 | 3D-printed controller: $5 |
| Follower arm + controller: ~$120 | Follower arm + controller: $122 |
| **Total: ~$230** | **Total: $127** |

## Requirements

- SO-100 follower arm
- 3D-printed handheld controller (STL in `/assets/`)
- USB webcam
- Python 3.10+

## Setup
```bash
uv sync  # or: pip install mujoco opencv-contrib-python scipy lerobot[feetech]
```

Print the controller from `/assets/` and attach 46mm AprilTags (DICT_APRILTAG_16h5, IDs 0-5).

Calibrate your camera:
```bash
python calibrate.py
```

On macOS:
```bash
bash mjpy-init.sh
```

## Usage
```bash
mjpython main.py
```

Controls: move controller to position end-effector, `u`/`j` for gripper, `ESC` to exit.

## How It Works

AprilTag detection runs in one thread, MuJoCo simulation in another, communicating via queue. The system fuses multi-face pose estimates with temporal smoothing, then applies Jacobian-based inverse kinematics with gravity compensation.

## Files

| File | Purpose |
|------|---------|
| `main.py` | Entry point |
| `april.py` | AprilTag detection |
| `mujoco_loop.py` | MuJoCo simulation and IK |
| `calibrate.py` | Camera calibration |
| `assets/` | Printable STLs |

---

Built with Python, OpenCV, MuJoCo, NumPy, SciPy


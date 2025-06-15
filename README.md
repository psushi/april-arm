# SO-100 Teleoperation System with AprilTag-Based Control

## 🎯 Project Objective

This project presents an innovative and cost-effective approach to robotic teleoperation and imitation learning for the SO-100 robotic arm. Instead of requiring expensive leader-follower arm setups, we utilize **AprilTag-based computer vision** with a **3D printed handheld controller** to create a virtual leader arm that can control both simulated and real SO-100 robots.

### Key Innovation
- **Zero-cost leader arm**: Replaces expensive physical leader arms with a simple 3D printed cube equipped with AprilTags
- **Virtual teleoperation**: Real-time control of simulated SO-100 using hand movements
- **Imitation learning pipeline**: Collect training data in simulation, then transfer to real robots
- **Scalable solution**: Dramatically reduces the hardware cost barrier for robotics research and education

## 🎬 Demo Video

Check out our **1-minute demonstration video** to see the system in action:
[`firstdraft.mp4`](./firstdraft.mp4)

## 🔧 System Architecture

### Hardware Components
- **3D Printed Handheld Controller**: A cube with AprilTags on each face (STL files in `/assets/`)
- **Webcam**: Standard USB camera for AprilTag detection
- **SO-100 Robot**: Target robot arm for teleoperation

### Software Stack
- **AprilTag Detection**: Real-time pose estimation using OpenCV
- **MuJoCo Simulation**: Physics-based robot simulation
- **Inverse Kinematics**: Real-time joint control for smooth motion
- **Multi-threading**: Parallel vision processing and robot control

## 🛠 Setup and Installation

### Prerequisites
- Python 3.10 or higher
- USB webcam
- 3D printer access (for controller fabrication)

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd ikso100_final/ikso100
   ```

2. **Install dependencies using uv** (recommended):
   ```bash
   # Install uv if you haven't already
   curl -LsSf https://astral.sh/uv/install.sh | sh
   
   # Install project dependencies
   uv sync
   ```

   **Or using pip**:
   ```bash
   pip install mujoco>=3.3.3 opencv-contrib-python>=4.11.0.86 opencv-python>=4.11.0.86 scipy>=1.15.3
   ```

3. **3D Print the Controller**:
   - Print the cube components from `/assets/` directory
   - Attach AprilTags (DICT_APRILTAG_16h5 family) to each face
   - Tag size: 46mm x 46mm

4. **Camera Calibration**:
   ```bash
   python calibrate.py
   ```
   This will generate `calib.npz` with your camera's intrinsic parameters.

5. **Initialize MuJoCo** (if needed):
   ```bash
   bash mjpy-init.sh
   ```

## 🚀 Running the System

### Basic Teleoperation Mode
```bash
python main.py
```

This launches both the vision processing and MuJoCo simulation in parallel threads.

### Individual Components

**AprilTag Detection Only**:
```bash
python april.py
```

**MuJoCo Simulation Only**:
```bash
python mujoco_loop.py
```

**Camera Calibration**:
```bash
python calibrate.py
```

### Controls
- **Hand Movement**: Move the 3D printed controller to control the robot's end-effector
- **Arrow Keys**: 
  - ↑ (UP): Open gripper
  - ↓ (DOWN): Close gripper
- **ESC/Q**: Exit the application

## 🧠 How It Works

### AprilTag-Based Pose Estimation
1. **Multi-Face Detection**: The system detects AprilTags on all visible faces of the cube
2. **Pose Fusion**: Combines multiple tag detections for robust 6DOF pose estimation
3. **Temporal Smoothing**: Applies low-pass filtering to reduce jitter and noise
4. **Coordinate Transformation**: Converts camera coordinates to robot workspace coordinates

### Real-Time Robot Control
1. **Inverse Kinematics**: Calculates joint angles for desired end-effector poses
2. **Jacobian-Based Control**: Uses differential kinematics for smooth motion
3. **Gravity Compensation**: Maintains natural arm behavior in simulation
4. **Joint Limits**: Respects robot's physical constraints

### Imitation Learning Pipeline
```
Hand Movements → AprilTag Tracking → Virtual Leader Arm → Simulated SO-100 → Data Collection → Real Robot Training
```

## 💰 Cost Comparison

| Traditional Setup | Our AprilTag System |
|------------------|-------------------|
| Leader Arm: $10,000+ | 3D Printed Controller: $5 |
| Follower Arm: $15,000+ | Same SO-100 Robot |
| **Total: $25,000+** | **Total: $15,005** |

**Savings: ~$10,000 per setup** 💸

## 📁 Project Structure

```
ikso100/
├── README.md              # This file
├── main.py               # Main application entry point
├── april.py              # AprilTag detection and pose estimation
├── mujoco_loop.py        # MuJoCo simulation and robot control
├── calibrate.py          # Camera calibration utility
├── aruco_detection.py    # Alternative ArUco marker detection
├── scene.xml             # MuJoCo scene configuration
├── so_arm100.xml         # SO-100 robot model definition
├── calib.npz             # Camera calibration parameters
├── camera_params.json    # Additional camera parameters
├── firstdraft.mp4        # Demo video
├── pyproject.toml        # Project configuration
├── assets/               # 3D printable STL files
│   ├── Base.stl
│   ├── Upper_Arm.stl
│   ├── Lower_Arm.stl
│   └── ...              # Additional robot components
└── photos/               # Documentation images
```

## 🔬 Technical Details

### AprilTag Configuration
- **Family**: DICT_APRILTAG_16h5
- **Size**: 46mm (configurable via `MARKER_SIZE`)
- **IDs**: 0-5 for cube faces

### Camera Setup
- **Position**: Behind robot, looking forward
- **Angle**: 45° downward tilt
- **Calibration**: Automatic intrinsic parameter estimation

### Robot Specifications
- **Joints**: 6 DOF (Rotation, Pitch, Elbow, Wrist Pitch, Wrist Roll, Jaw)
- **Control**: Position-based with velocity limits
- **Workspace**: Optimized for desktop manipulation tasks

## 🤝 Contributing

We welcome contributions! Areas for improvement:
- Enhanced pose estimation algorithms
- Real robot integration
- Data collection interfaces
- Machine learning model training

## 📄 License

This project is open-source. Please check the repository for specific license details.

## 🎓 Applications

- **Robotics Education**: Low-cost setup for learning robot control
- **Research**: Data collection for imitation learning studies  
- **Prototyping**: Rapid testing of robot behaviors
- **Remote Operation**: Teleoperation across networks

---

**Built with**: Python, OpenCV, MuJoCo, NumPy, SciPy

*Revolutionizing robotic teleoperation, one AprilTag at a time! 🤖*

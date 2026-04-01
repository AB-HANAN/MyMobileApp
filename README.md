# 🤖 AIDE Mobile App

AIDE (Autonomous Intelligent Delivery Entity) is a smart mobile-controlled robotic system designed for real-time human-following, remote control, and AI-assisted interaction.
This repository contains the **Flutter-based mobile application** used to control and monitor the AIDE robot.


##FIgma Design Link --> https://github.com/AB-HANAN/MyMobileApp
---

## 📱 Overview

The AIDE Mobile App acts as the **control interface** between the user and the robot running on a Jetson-based system.
It enables users to interact with the robot through multiple modes including manual control, autonomous following, and AI chat.

The application is designed with a clean UI and modular architecture, ensuring smooth communication with the backend via HTTP APIs.

---

## ✨ Features

* 🔐 **Authentication System**

  * Admin and User roles
  * Secure login and registration using key-based access

* 📡 **Robot Connection**

  * Connect to Jetson device using Base URL
  * Real-time communication with backend

* 🎮 **Manual Drive Mode**

  * Control robot movement (forward, reverse, left, right)
  * Interactive control buttons

* 🤖 **Person Following Mode**

  * Enable/disable autonomous human-following
  * Integrated with YOLO-based tracking system

* 🧭 **Localization Mode**

  * Visualize robot movement and mapping
  * Supports trace and replay functionality

* 💬 **AI Chat Interface**

  * Communicate with onboard AI assistant
  * Powered by locally hosted LLM (Jetson)

* 📊 **Dashboard**

  * Central control panel
  * Displays robot status and navigation options

* 👤 **Profile Management**

  * Update user/admin details
  * Manage keys and identity

---

## 🏗️ Project Architecture

The app follows a modular Flutter architecture:

lib/
├── main.dart → Entry point
├── models/ → Data models (e.g., roles)
├── screens/ → UI screens (login, dashboard, modes)
├── widgets/ → Reusable UI components
├── services/ → API communication layer
├── theme/ → App styling

---

## 🔌 Backend Integration

The mobile app communicates with the robot via REST APIs:

* `POST /cmd` → Send control commands
* `GET /telemetry` → Receive robot status
* Additional endpoints for AI and control features

The backend runs on a **Jetson Orin Nano**, handling:

* Computer vision (YOLO + OCR)
* Depth sensing (Kinect)
* Motion control
* AI inference (LLM)

---

## 🛠️ Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend:** Python (Flask / FastAPI)
* **AI Models:** YOLOv8, EasyOCR, Local LLM (Ollama)
* **Hardware:** Jetson Orin Nano, Kinect Depth Sensor

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/AB-HANAN/MyMobileApp.git
cd MyMobileApp
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

---

## 📷 Screens (UI Preview)

* Login & Registration
* Dashboard
* Manual Drive
* Person Following
* Localization
* AI Chat

*(Add screenshots here for better presentation)*

---

## 🎯 Project Purpose

This project is developed as a **Final Year Project (FYP)** with the goal of:

* Building a cost-effective autonomous robot
* Enabling intelligent human-following without expensive sensors (no LiDAR)
* Providing remote control via mobile interface
* Integrating AI-based interaction locally on edge devices

---

## 🔮 Future Improvements

* Live video streaming inside Flutter app
* Cloud-based remote access (Cloudflare tunnel)
* Improved UI/UX animations
* Multi-robot support
* Voice control integration

---

## 👨‍💻 Author

**Abdul Hanan / AIDE Team**
Final Year Project – Autonomous Robotics System

---

## 📄 License

This project is for academic and research purposes.

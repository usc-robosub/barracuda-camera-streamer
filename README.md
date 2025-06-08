# Barracuda Camera Streamer

A ROS-based camera streaming system that captures video from a camera device and publishes image data for YOLO object detection inference.

## Overview

This project serves as the camera input component for the barracuda-vision computer vision pipeline. It captures video frames from a camera device, converts them to ROS Image messages, and publishes them to a ROS topic for downstream processing by YOLO inference nodes.

## Features

- Real-time camera capture from `/dev/video0`
- ROS Image message publishing to `/yolo_input_image` topic
- Fallback to dummy frames when camera is unavailable
- Dockerized deployment with ROS Noetic
- Configurable video resolution (640x480) and frame rate (30 FPS)

## Prerequisites

- Docker and Docker Compose
- Camera device accessible at `/dev/video0`
- Integration with [barracuda-vision](https://github.com/username/barracuda-vision) repository

## Quick Start

1. Build and run the containers:
   ```bash
   docker-compose up --build
   ```

2. The system will start two services:
   - `barracuda-description`: ROS core service
   - `cam-to-yolo`: Camera publisher service

## Architecture

- **ROS Node**: `camera_publisher` publishes to `/yolo_input_image` topic
- **Image Format**: BGR8 color images at 640x480 resolution
- **Publish Rate**: 10 Hz
- **Fallback**: Black dummy frames when camera is unavailable

## Integration

This streamer is designed to work with the barracuda-vision inference system. The published images on `/yolo_input_image` are consumed by YOLO detection nodes for real-time object detection and analysis.

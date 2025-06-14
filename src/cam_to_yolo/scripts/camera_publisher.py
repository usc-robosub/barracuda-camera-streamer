#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np

def main():
    rospy.init_node('camera_publisher', anonymous=True)
    pub = rospy.Publisher('/yolo_input_image', Image, queue_size=1)
    bridge = CvBridge()
    rate = rospy.Rate(10)

    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
    cap.set(cv2.CAP_PROP_FPS, 30)

    # Initialize dummy frame for fallback
    dummy_frame = np.zeros((480, 640, 3), dtype=np.uint8)
    
    if not cap.isOpened():
        rospy.logwarn("Camera not found at /dev/video0. Using fallback black image.")

    try:
        while not rospy.is_shutdown():
            if cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    rospy.logwarn("Failed to grab frame, using fallback")
                    frame = dummy_frame.copy()
            else:
                frame = dummy_frame.copy()

            try:
                ros_img = bridge.cv2_to_imgmsg(frame, "bgr8")
                pub.publish(ros_img)
            except Exception as e:
                rospy.logerr("Error converting/publishing image: %s", str(e))

            rate.sleep()
    finally:
        if cap.isOpened():
            cap.release()
            rospy.loginfo("Camera released")

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass

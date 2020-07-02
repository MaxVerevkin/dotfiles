#!/bin/env python3

from subprocess import run,PIPE
from time import sleep
import math


# Config
delay = 10
animation_duration = 5


# Execute programm and return stdout
def cmd(params):
    return run(params, stdout=PIPE, text=True).stdout


# Logarithmic transition
def ln(x):
    return math.log(1.7*x + 1) + .21


# Calculate new brightness
def calc_brightness():
    # Get pixel value from camera (from 0 to 1)
    pixel = int(cmd(["sh", "-c", "ffmpeg -i /dev/video0 -vf scale=1:1 -pix_fmt gray -f rawvideo -frames:v 1 -v quiet pipe:1 | od -t u | sed 's/000000[01]\s*//'"])) / 255

    # Process the pixel value
    return ln(pixel)


# Get max brightness
max_brightness = int(cmd(["brightnessctl", "m"]))
# Get current brightness
prev_brightness = int(cmd(["brightnessctl", "g"]))


while (True):
    # Get new brightness
    brightness = int(max_brightness * calc_brightness())

    # Animate
    delta = brightness - prev_brightness
    frames = abs(delta)
    if frames != 0:
        frame_duration = animation_duration / frames
        frame_step = 1 if delta > 0 else -1
        for i in range(frames):
            prev_brightness += frame_step
            run(["brightnessctl", "s", str(prev_brightness)])
            sleep(frame_duration)
        sleep(delay)
    else:
        sleep(delay + animation_duration)

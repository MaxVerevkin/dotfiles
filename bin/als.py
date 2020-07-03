#!/bin/env python3

from subprocess import run,PIPE
from time import sleep
import math


# Config
delay = 10
animation_duration = 10

# Camera config
camera_config = [("brightness", "0"),
        ("contrast", "50"),
        ("saturation", "64"),
        ("gamma", "300"),
        ("gain", "64"),
        ("backlight_compensation", "0"),
        ("exposure_auto", "1"),
        ("exposure_absolute", "3000"),
        ("exposure_auto_priority", "0")]
for conf in camera_config:
    run(["v4l2-ctl", "--set-ctrl", conf[0]+"="+conf[1]])


# Execute programm and return stdout
def cmd(params):
    return run(params, stdout=PIPE, text=True).stdout


# Logarithmic transition
def brightness_transition(x):
    return math.log(2*x + 1) + .2


# Get ambient value (from 0 to 1)
def get_ambient():
    return int(cmd(["sh", "-c", "ffmpeg -i /dev/video0 -vf scale=1:1 -pix_fmt gray -f rawvideo -frames:v 1 -v quiet pipe:1 | od -t u | sed 's/000000[01]\s*//'"])) / 255


# Get max brightness
max_brightness = int(cmd(["brightnessctl", "m"]))
# Get current brightness
prev_brightness = int(cmd(["brightnessctl", "g"]))


while (True):
    # Get average ambient value
    ambient = get_ambient() / 2
    sleep(delay)
    ambient += get_ambient() / 2

    # Calc new brightness
    brightness = int(brightness_transition(ambient) * max_brightness)

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
    else:
        sleep(animation_duration)



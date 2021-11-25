# Fiducial marker tracking as haptic interface for spatial audio player
## Bachelor thesis by Vilém Jonák, supervision Vojtech Leischner
Standalone fiducial markers tracking using a web camera. The application has a graphical user interface and is very simple to use. Tracking data are sent to a selected IP address as WebSocket string or OSC. Software is part of the interface to enable spatial audio rendering controlled with haptics interface. However, it can be used for any other use-cases that involve fiducial marker tracking. Developed by Vilém Jonák as part of bachelor thesis at Czech Technical University in Prague under the tutelage of Vojtech Leischner. Supported by Human interaction department CVUT https://dcgi.fel.cvut.cz/

<img src="./images/tabletop_schema.jpg" width="375" height="357" />

## TODO LIST
* add user option to set time delay after which the marker instance is discarded when the marker was not detected for longer than x miliseconds
* enable perspective deformation of camera image to support camera from angle setup
* create builds for all major platforms - win, macos, linux
* create video demo
* port to raspberry pi - add camera exposore control
* enable for different type of markers and let user control the max number of markers tracked

## Download
* [Windows64bit](https://mega.nz/file/pBZVxQoS#CQicvcYtOaZTkJv2YbP3XL4akb-QZu1OEyeFXb7_AoM) - version 1.0
* [Linux64bit](https://mega.nz/file/tFQVWKoT#WH5LBp3tQRrBptjvUZaxjd0AG1g5zXfEui9OqQN1vr8) - version 1.0
* [MacOS](https://mega.nz/file/NRIlxQRK#BeU4kAl60qU1KTf7Ii2AmIxcMvEjUTDoPEW0qywfckc) - version 1.0

Download links provide zipped archive with the tool. You don't need to install anything - just unzip it and run executable file.

### Windows
Tested on Windows 10. It should work out of the box. Just double click the "XXXX.exe" file. If you are using antivirus such as Windows Defender it will show warning - you can safely click "More info" and choose "Run anyway". Next time it should run without warning.

### MacOS
Tested on Catalina OS. On MacOs you need to allow installation from unknown sources. Open the Apple menu > System Preferences > Security & Privacy > General tab. Under Allow apps downloaded from select App Store and identified developers. To launch the app simply Ctrl-click on its icon > Open.

### Linux
Tested on Ubuntu 64bit. You can always run the app from the terminal. If using GUI and the app does not run when you double click the "XXXX" file icon you need to change the settings of your file explorer. In Nautilus file explorer click the hamburger menu (three lines icon next to minimise icon ), select "preferences". Click on "behaviour" tab, in the "Executable Text Files" option select "Run them". Close the dialogue and double click the "XXXXX" file icon (bash script) - now it should start.

## What is this good for?

## How to use it?
After unzipping simply double click the executable to run the application. 

Note that you can also adjust few settings. Click on the "XXXX" tab.  
* some settings - what it does
* other one....

## How does it work?
Under the hood the tool is programmed in Java Processing. For marker detection we are using NyARToolkit library for processing: https://github.com/nyatla/NyARToolkit-for-Processing/blob/master/README.EN.md and Control P5 for GUI https://github.com/sojamo/controlp5. For camera capture we rely on Video library based on Gstreamer https://processing.org/reference/libraries/video/index.html.

## Camera Calibration
We are using a general camera calibration model but you can create a custom one as well. Simply delete the camera_para.dat file and replace it with your own. Please refer to utility programs included with ARToolKit to calibrate your video camera if you want to achieve more precise results and to export the necessary file. See http://www.hitl.washington.edu/artoolkit/documentation/usercalibration.htm for more.

## MIT License
Copyright © 2021 Vilem Jonak, Vojtech Leischner

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

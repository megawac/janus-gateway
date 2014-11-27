 gst-launch-1.0 v4l2src ! video/x-raw-yuv,width=640,height=480,framerate=15/1 ! aspectratiocrop aspect-ratio=16/9 ! ffmpegcolorspace ! xvimagesink

gst-launch-0.10 -e videotestsrc pattern="snow" ! video/x-raw-yuv, framerate=10/1, width=200, height=150 ! videomixer name=mix ! \
   ffmpegcolorspace ! xvimagesink videotestsrc ! video/x-raw-yuv, framerate=10/1, width=640, height=360 ! mix.

 gst-launch-0.10 -e v4l2src ! video/x-raw-yuv,format=\(fourcc\)YUY2,width=1280,height=720,framerate=5/1 ! \
   ffmpegcolorspace ! \
   timeoverlay halign=right valign=top ! clockoverlay halign=left valign=top time-format="%Y/%m/%d %H:%M:%S" ! \
   tee name="splitter" ! queue ! xvimagesink sync=false splitter. ! \
   queue ! videorate ! video/x-raw-yuv,framerate=1/1 ! \
   theoraenc bitrate=256 ! oggmux ! filesink location=webcam.ogg

 gst-launch-0.10 videotestsrc ! clockoverlay halign=right valign=bottom shaded-background=true time-format="%Y.%m.%D" ! ffmpegcolorspace ! ximagesink

 gst-launch v4l2src ! video/x-raw-yuv,width=128,height=96,format='(fourcc)'UYVY ! ffmpegcolorspace ! ffenc_h263
      ! video/x-h263 ! rtph263ppay pt=96 ! udpsink host=192.168.1.1 port=5000 sync=false
      Use this command on the receiver

gst-launch-1.0 v4l2src ! video/x-raw-yuv,width=128,height=96,format='(fourcc)'UYVY ! ffmpegcolorspace ! ffenc_h263
      ! video/x-h263 ! rtph263ppay pt=96 ! udpsink host=192.168.1.1 port=5000 sync=false





gst-launch v4l2src ! \
    video/x-raw-yuv,width=640,height=480,framerate=15/1 ! \
    aspectratiocrop aspect-ratio=16/9 ! \
    ffmpegcolorspace ! timeoverlay ! \
    vp8enc error-resilient=true ! \
    rtpvp8pay ! udpsink host=127.0.0.1 port=5004





  gst-launch-0.10 videotestsrc num-buffers=500 ! video/x-raw-yuv, framerate=25/1, width=640, height=360 ! x264enc ! mpegtsmux ! filesink location=test.ts

gst-launch -e v4l2src ! video/x-raw-yuv, framerate=10/1, width=320, height=240 ! ffmpegcolorspace ! \
               x264enc bitrate=256 ! flutsmux ! filesink location=/tmp/streams/webcam.ts
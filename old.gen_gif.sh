
# reference from
# https://superuser.com/questions/1049606/reduce-generated-gif-size-using-ffmpeg
# https://cassidy.codes/blog/2017/04/25/ffmpeg-frames-to-gif-optimization/


# reduce video duplicated frame, the downside is it will spped the video up
# https://stackoverflow.com/questions/37088517/remove-sequentially-duplicate-frames-when-using-ffmpeg


# how reduce size 
# https://askubuntu.com/questions/107726/how-to-create-animated-gif-images-of-a-screencast/110320#110320

vid=$1
start_time=00:00:01
duration=99999      
# this will dramatically reduce gif size, but lose color
max_colors=256
fps=10          # frames per a second .
palette="/tmp/palette.png"
filters="fps=$fps,scale=-1:-1:flags=lanczos"
# filters="fps=$fps,scale=640:-1:flags=lanczos"

# a little big

# ffmpeg -ss $start_time                             \
#        -t  $duration                               \
#        -i  "$vid"                                  \
#        -vf "$filters,palettegen"                   \
#        -y  $palette                                &&
# ffmpeg -ss $start_time                             \
#        -t  $duration                               \
#        -i  "$vid"                                  \
#        -i  $palette                             \
#        -lavfi "$filters [x]; [x][1:v] paletteuse"  \
#        -y  "$vid".gif                              &&



convert_process(){
	convert $1 -fuzz 1% -layers Optimize converted.$1 &
}


# ffmpeg -v warning -i "$vid" -vf "$filters,palettegen=stats_mode=diff" -y $palette

# ffmpeg -i "$vid" -i $palette -lavfi "$filters,paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y "$vid".2.gif

ffmpeg -v warning -i "$vid" -vf "$filters,palettegen=stats_mode=diff:max_colors=$max_colors" -y $palette


ffmpeg -i "$vid"  -pix_fmt rgb24   -y "$vid".rgb24.gif
convert_process "$vid".rgb24.gif

ffmpeg -i "$vid" -lavfi "$filters" -y "$vid".nopalette.gif
convert_process "$vid".nopalette.gif

ffmpeg -i "$vid" -i $palette -lavfi "$filters" -y "$vid".nodither.gif
convert_process "$vid".nodither.gif

ffmpeg -i "$vid" -i $palette -lavfi "$filters,paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y "$vid".gif
convert_process "$vid".gif

ffmpeg -i "$vid" -i $palette -lavfi "$filters,mpdecimate,paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y "$vid".mpdecimate.gif
convert_process "$vid".mpdecimate.gif

ffmpeg -i "$vid" -i $palette -lavfi "$filters,mpdecimate" -y "$vid".nodither.mpdecimate.gif
convert_process "$vid".nodither.mpdecimate.gif

ffmpeg -i "$vid" -vsync 0 -filter_complex "[0:v] scale=-1:-1,mpdecimate,fps=$fps,split [a][b];[a] palettegen=max_colors=$max_colors [p];[b][p] paletteuse=dither=bayer:bayer_scale=5" -y "$vid".raw_mpdecimate.gif
convert_process "$vid".raw_mpdecimate.gif



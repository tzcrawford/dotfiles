#!/usr/bin/gnuplot -p

### GUI/Frontend and Exection Options
#Note, you may need to run gnuplot with the -p flag to keep gui window from immediately closing
#set term wxt
#set term qt
#set term x11
#set term png
set term png transparent truecolor background rgb '#000000' size 1600,1200 font "Liberation Mono:style=Bold,45"
#set term svg enhanced size 500,500

###Output Options
set output "a.png"

###Input Options
#set datafile separator ","
#set datafile separator "\t"

###Legend options
#unset key
set key right top
#set key box lc rgb '#000000' #sets box around legend
#set key opaque #sets key on opaque background such that plots don't draw over it
set key tc rgb '#000000'
set key font ",40"
#set key spacing 1.5 #sets how far apart the lines in the key are vertically
#set key samplen 4 #sets how wide the key samples are

set border lw 4 lc rgb '#000000'

###Primary Graph Options
#set title "Title"
set xlabel "X" tc rgb '#000000'
set ylabel "Y" tc rgb '#000000'
set xrange [-1:1]
set yrange [-1:1]
#set logscale y
#set format y "10^{%L}" #logscale
#set format y "%.2tE%T" #scientific notation
#format specifiers listed here: http://www.gnuplot.info/docs_4.2/gnuplot.html#x1-18600043.21.2
#set xtics ('-2π' -2*pi, '-π' -pi, 0, 'π' pi, '2π' 2*pi)  #sets exactly where to put ticks and labels
set xtics 1                                #major x tick spacing
set ytics 1                                 #major y ticks per major tick
set mxtics 4                                #minor x ticks per major tick
set mytics 10                               #minor y ticks per major tick
set grid                                    #enables grid on major ticks


###Functions
f(x) = sin(x/2)
f2(x) = sin(x)
f3(x) = sin(2*x)
f4(x) = sin(4*x)
set samples 10000 #number of points plotted for functions

#point types: 1(+ sign), 2(X), 3(asterisk), 4(empty square), 5(filled square), 6(empty circle), 7(filled circle), 8(empty triangle), 9(filled triangle), 10(empty upside down triangle), 11(filled upside down triangle), 12(empty diamond), 13(filled diamond)

###Some custom linestyles
set style line 99 lw 4 pt 1 pointsize 3 lc rgb '#FFFFFF' # white 
set style line 1 lw 4 pt 1 ps 3 lc rgb '#000000' # black
set style line 2 lw 4 pt 2 ps 3 lc rgb '#CC0000' # red 
set style line 3 lw 4 pt 3 ps 3 lc rgb '#000099' # blue 
set style line 4 lw 4 pt 4 ps 3 lc rgb '#006600' # green 
set style line 5 lw 4 pt 5 ps 3 lc rgb '#FF8000' # orange 
set style line 6 lw 4 pt 6 ps 3 lc rgb '#FF007F' # pink 
set style line 7 lw 4 pt 7 ps 3 lc rgb '#00FFFF' # cyan 
set style line 8 lw 4 pt 8 ps 3 lc rgb '#606060' # gray 
set style line 9 lw 4 pt 9 ps 3 lc rgb '#331900' # brown 
set style line 10 lw 4 pt 10 ps 3 lc rgb '#FFFF00' # yellow 
set style line 11 lw 4 pt 11 ps 3 lc rgb '#33FF33' # light green 
set style line 12 lw 4 pt 12 ps 3 lc rgb '#FFB266' # light orange 
set style line 13 lw 4 pt 13 ps 3 lc rgb '#FF99CC' # light pink 
set style line 14 lw 4 pt 1 ps 3 lc rgb '#9999FF' # light blue 
set style line 15 lw 4 pt 2 ps 3 lc rgb '#C0C0C0' # light gray 

###Your Plots Here 
plot f(x) with lines linestyle 1 title "sin(x)", \
f2(x) with lines linestyle 2 title "sin(2x)", \
f3(x) w l ls 3 t "sin(3x)", \
f4(x) w l ls 4 t "sin(4x)"

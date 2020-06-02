#!/usr/bin/gnuplot -p
###Edit this script and execute in the terminal with "gnuplot scriptname.plt"
#You can also repeat commands one-by-one in the gnuplot terminal, which can be executed by just entering the command "gnuplot"
#save "savefile.plt"
#And load into gnuplot later with
#load "savefile.plt"
#Note this is worse than editing a template such as this, as many other options will fill the .plt file and confuse the reader. It is much better to write a script and load it later.

### GUI/Frontend and Exection Options
#Note, you may need to run gnuplot with the -p flag to keep gui window from immediately closing
set term wxt                                ###GTK API terminal, allows for use of cursor with ruler etc.
#set term qt                                ###Qt API terminal
#set term x11                               ###Xterm, default for Xwindow systems
#set term png                               ###png terminal, Best for immediately outputting to a file
#set term png transparent truecolor background rgb '#000000' size 1600,1200 font "Liberation Mono:style=Bold,45" ###png terminal with transparent background but white on any opaque areas. Size 800x600 pixels.
#set term svg enhanced size 500,500         ###svg terminal 5in by 5in

###Output Options
#set output "a.png"                          ###sets output file and extension
#set output "a.jpg"
#set output "a.svg"

###Input Options
#set datafile separator ","                 #for plotting data from a comma separated variable (csv) file
#set datafile separator "\t"                #for plotting data from a tab separated variable (tsv) file

###Legend options
#unset key                                  #disables legend 
set key right top                           #enables legend and where
#set key box lc rgb '#000000'                #sets box around legend
#set key opaque                              #sets key on opaque background such that plots don't draw over it
set key tc rgb '#000000'                    #sets color of writing within key
set key font ",40"                         #legend font and size
#set key spacing 1.5                        #sets how far apart the lines in the key are vertically
#set key samplen 4                          #sets how wide the key samples are

set border lw 4 lc rgb '#000000'                 #sets plot border a specific color



###Primary Graph Options
#set title "Title"                           #title
set xlabel "X" tc rgb '#000000'             #x axis label and color
set ylabel "Y" tc rgb '#000000'             #y axis label and color
set xrange [-2*pi:2*pi]                     #x axis range
set yrange [-1:1]                           #y axis range
#set logscale y                             #makes y a logscale
#set format y "10^{%L}"                     #formatting to make logscale look good
#set format y "%.2tE%T"                     #scientific notation
#format specifiers listed here: http://www.gnuplot.info/docs_4.2/gnuplot.html#x1-18600043.21.2
set xtics ('-2π' -2*pi, '-π' -pi, 0, 'π' pi, '2π' 2*pi)  #sets exactly where to put ticks and labels
#set xtics 1                                #major x tick spacing
set ytics 1                                 #major y ticks per major tick
set mxtics 4                                #minor x ticks per major tick
set mytics 10                               #minor y ticks per major tick
set grid                                    #enables grid on major ticks


###Functions
f(x) = sin(x/2)
f2(x) = sin(x)
f3(x) = sin(2*x)
f4(x) = sin(4*x)
set samples 10000                           #enables the number of points plotted for functions (make larger if graph not smooth)

###You can do math, etc in gnuplot. May not be particularly useful
#a=10
#print a
#print log(a)
#f(x) = a*sin(x)

###Plot Options
#As the final command, tell gnuplot to plot either a function or a datafile with a specific two-column set
#plot f(x)
#plot '/directory/route/datafile.dat' using 1:2
#Or follow with any options you may like. You can alternatively use the shorthand notation
#plot f(x) title "f(x)" linestyle 1 with lines, \
#plot "/home/user/file.dat' u 1:3 t "file" ls 1 w l

#Note you can plot more than one thing at a time by separating with a comma (,)
#You can issue more on the following line with an escape character (\)

#Declare how the datapoints in the plot appear. Plot with one of the following options
#lines (l), points (p), dots, linespoints (lp), impulses, steps
#As far as I am aware, there are 13 different types of points to use. 14, 15, etc will just cycle through again
#1(+ sign), 2(X), 3(asterisk), 4(empty square), 5(filled square), 6(empty circle), 7(filled circle), 8(empty triangle), 9(filled triangle), 10(empty upside down triangle), 11(filled upside down triangle), 12(empty diamond), 13(filled diamond)

#you can also make a histogram with bars of a given width
#set boxwidth 0.1
#plot "input.dat" using 1:2 with boxes
#or with widths in a third datafile column
#plot "input.dat" using 1:2:3 with boxes

#Utilize error bars by including another column of data
#plot "input1.dat" using 1:2:3 with yerrorbars ### w/ errorbars

###Some custom linestyles
#lw is for line width (thickness)
#pt is for point type (which shape the marker is). I believe there are only 15 to choose from
#lc rgb '#~~~~~~' declares the line color
set style line 99 lw 4 pt 1 pointsize 3 lc rgb '#FFFFFF'      # white 
set style line 1 lw 4 pt 1 ps 3 lc rgb '#000000'      # black
set style line 2 lw 4 pt 2 ps 3 lc rgb '#CC0000'      # red 
set style line 3 lw 4 pt 3 ps 3 lc rgb '#000099'      # blue 
set style line 4 lw 4 pt 4 ps 3 lc rgb '#006600'      # green 
set style line 5 lw 4 pt 5 ps 3 lc rgb '#FF8000'      # orange 
set style line 6 lw 4 pt 6 ps 3 lc rgb '#FF007F'      # pink 
set style line 7 lw 4 pt 7 ps 3 lc rgb '#00FFFF'      # cyan 
set style line 8 lw 4 pt 8 ps 3 lc rgb '#606060'      # gray 
set style line 9 lw 4 pt 9 ps 3 lc rgb '#331900'      # brown 
set style line 10 lw 4 pt 10 ps 3 lc rgb '#FFFF00'     # yellow 
set style line 11 lw 4 pt 11 ps 3 lc rgb '#33FF33'     # light green 
set style line 12 lw 4 pt 12 ps 3 lc rgb '#FFB266'     # light orange 
set style line 13 lw 4 pt 13 ps 3 lc rgb '#FF99CC'     # light pink 
set style line 14 lw 4 pt 1 ps 3 lc rgb '#9999FF'     # light blue 
set style line 15 lw 4 pt 2 ps 3 lc rgb '#C0C0C0'     # light gray 


###Plotting individual points
#Simply make a datafile with only one line of data and plot as usual
#Alternatively you can issue these in the gnuplot terminal. I don't think you can accomplish this in a script.
#    plot '-' w p ls 1, '-' w p ls 2, '-' w p ls 3
#    1 2 
#    e   
#    2 1 
#    e   
#    3 1.5 
#    e   

###Labeling individual points
#set label "point a" at 1,2

###Your Plots Here 
plot f(x) with lines linestyle 1 title "sin(x)", \
f2(x) with lines linestyle 2 title "sin(2x)", \
f3(x) w l ls 3 t "sin(3x)", \
f4(x) w l ls 4 t "sin(4x)"



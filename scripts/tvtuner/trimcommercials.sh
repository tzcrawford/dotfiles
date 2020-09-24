#!/bin/sh
#removes commercial breaks from TV show episodes, edit below
#want recordings with filenames of the form:
#   2020-09-10-18-57_Jeopardy.mpeg
#   year-month-day-hour-minute_title.mpeg
#                   (when recording starts)

title="Jeopardy" #name of the TV show
year="2020"
recordstart="18-57" #time we start the recording
numclips=4 #number of clips we are splitting video into (commercial breaks + 1)

#The date and the start/end times of each clip. Each line is a clip.
#Don't use tab characters in this array?
array=(\
"09-14" "00:03:00.5" "00:09:08" \
        "00:11:32.5" "00:15:50" \
        "00:18:14.5" "00:25:08" \
        "00:28:30" "00:30:35.5" \
)


starttimes=();endtimes=()
i=0
while [ $i -lt ${#array[@]} ]; do
    date=${array[$i]}
    echo $date
    (( i++ ))

    for j in $(seq 1 $numclips); do
        starttimes+=(${array[$i]})
        echo ${array[$i]}
        (( i++ ))
        endtimes+=(${array[$i]})
        echo ${array[$i]}
        (( i++ ))
    done

    rm files_to_concatenate_$date-$title.txt 2>/dev/null #in case it exists for some reason

    for k in ${!starttimes[@]}; do #k is the index number
        #generate the clips in mp4
        ./to720p.sh $year-$date-${recordstart}_${title}.mpeg $year-$date-${recordstart}_${title}_$k.mp4 "${starttimes[k]}" "${endtimes[k]}"
        #put the title of the clips in a file so we can concatenate them by name
        echo "file '$year-$date-${recordstart}_${title}_$k.mp4'" >> files_to_concatenate_$date-$title.txt
    done
    
    
    #concatenate videos into final mp4
    ffmpeg -f concat -safe 0 -i files_to_concatenate_$date-$title.txt -c copy $year-$date-$title.mp4 
    
    #clean up
    for k in ${!starttimes[@]}; do #delete individual clips
        rm $year-$date-${recordstart}_${title}_$k.mp4 2>/dev/null
    done

    starttimes=();endtimes=() #reset these arrays
    rm files_to_concatenate_$date-$title.txt 2>/dev/null

done

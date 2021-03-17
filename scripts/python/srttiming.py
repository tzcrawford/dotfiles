#!/usr/bin/python

#enter a time pos/neg to add/subtract from every subtitle time
#ex main("/path/to/file.srt",20.3) would add 20.3 seconds
defaultfilename="subtitles.srt"
defaulttimechange=32

#takes the main text input of the srt file and outputs a list.
#Each element of this list represents an individual subtitle.
#The element is a list and its first element is the subtitle no,
#second is the timings, and third is the actual subtitle string
def separatesubtitles(lines):
    indexesOfSubtitles=list()
    for lineno,line in enumerate(lines):
        #if the line contains only an integer and does not follow a timestamp (containing -->), it must be a subtitle index
        try:
            int(line)
            if "-->" in lines[lineno-1]:
                pass
            else:
                indexesOfSubtitles.append(lineno) 
        except:
            pass


    subtitles=list() #is the output list variable

    for i,subtitleline in enumerate(indexesOfSubtitles):
        #i is the index in this loop and subtitleline is the line in the file where that subtitle information begins
        dummy=list() #will hold the 3-element list we append to "subtitles" variable
        thissubtitle=list() #each line printed for this subtitle in the file
        if(i==len(indexesOfSubtitles)-1):
            nextsubtitleline=len(lines)
        else:
            nextsubtitleline=indexesOfSubtitles[i+1]
        for j in range(nextsubtitleline-subtitleline): #this is essentially the number of lines this subtitle section takes up in the file
            thissubtitle.append(lines[subtitleline+j])
            
        dummy.append(thissubtitle[0]) #the index number for the subtitle which is printed in the file
        dummy.append(str(thissubtitle[1])) #the second element is the line after the subtitle index i.e. the timings for that subtitle.
        del thissubtitle[1];del thissubtitle[0];del thissubtitle[-1] #delete the two lines we already appended as well as the last line because it is just empty.
        #Now thissubtitle should only obtain the text which is printed on the screen, which may be multiple lines.
        dummy.append(thissubtitle)
        subtitles.append(dummy)

    return subtitles

def fixtime(subtitles, timechange):
    for i in range(len(subtitles)):
        timestamp=subtitles[i][1]
        timestamp=timestamp.replace(",",".") #seconds now a decimal
        timestamp=timestamp.strip(" ").split("-->") #timestamp is now a list with just the two times

        #now we separate those times into a list of hours,minutes,seconds,miliseconds
        initime=timestamp[0].split(":")
        fintime=timestamp[1].split(":")

        #datetime package is literally retarded, so we do this manually.
        iniseconds=int(initime[0])*60*60 + int(initime[1])*60 + float(initime[2])
        finseconds=int(fintime[0])*60*60 + int(fintime[1])*60 + float(fintime[2])

        iniseconds+=timechange
        finseconds+=timechange
        
        dummy=list()
        for j in [iniseconds,finseconds]:
            hours=int(j/3600)
            remainder=j%3600 #this many seconds remain
            minutes =int(remainder/60)
            seconds=remainder%60 #now this many seconds remain

            hours="{:02d}".format(hours) #add leading zero if one digit e.g. "05"
            minutes="{:02d}".format(minutes)
            seconds="{0:.3f}".format(seconds) #round to 3 decimals
            #these are strings now

            dummy.append( (hours + ":" + minutes + ":" + seconds).replace(".",",") ) #to get our initial format back

        timestamp= dummy[0] + " --> " + dummy[1]

        subtitles[i][1]=timestamp
    
    return subtitles
            

def changetotext(subtitles):
    output=list()
    for i in subtitles:
        output.append(str(i[0])) #the subtitle index
        output.append(i[1]) #the timestamp
        for j in i[2]: #the contents of the subtitle itself
            output.append(j)
        output.append("") #a newline separator as per srt syntax (but \n is included with f.write)
    return output

#does the main job of adding/subtracting time to all subtitles
def main(filename,timechange):
    f=open(filename,"r",encoding='latin-1')
    #lines=f.readlines() #this leaves newline character
    lines = f.read().splitlines()
    f.close()

    subtitles=separatesubtitles(lines)
    subtitles=fixtime(subtitles,timechange)
    output=changetotext(subtitles)

    outputfilename=filename[:-4] + "-fixed.srt" #remove file extension and append to name
    f=open(outputfilename, "w")
    for i in output:
        f.write(i+ "\n")
    f.close()

    return

if __name__ == '__main__':
    main(defaultfilename,defaulttimechange)

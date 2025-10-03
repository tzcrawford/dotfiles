#!/bin/sh
#fixes xdg defaults to my preference

#determine a file's MIME type
#xdg-mime query filetype photo.jpg
#returns "image/jpeg"

#determine the default application for a MIME type
#xdg-mime query default image/jpeg
#returns "gimp.desktop" etc

#change the default application for a MIME type
xdg-mime default zathura.desktop application/pdf application/oxps application/epub_zip applica/pdf 
xdg-mime default nsxiv.desktop image/png image/jpeg
xdg-mime default mpv.desktop video/x-matroska video/mp4 video/x-msvideo video/webm video/x-flv video/quicktime video/x-ms-wmv video/MP2T application/x-mpegURL video/3gpp audio/aiff audio/midi audio/mpeg audio/mpeg3 audio/basic audio/wav
xdg-mime default libreoffice-writer.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document application/msword application/vnd.oasis.opendocument.text
if [ $BROWSER = "" ] ; then
    xdg-mime default qutebrowser.desktop text/html message/rfc822
fi
#xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop #seems to be a fix issues with http links resorting to other browsers

# These allow installed electron apps to open links in qutebrowser.
xdg-mime default qutebrowser.desktop x-scheme-handler/http
xdg-mime default qutebrowser.desktop x-scheme-handler/https

#be aware, $APPLICATION.desktop must exist in /usr/share/applications
#generally included with installation, but can also be manually made


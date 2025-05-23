#!/bin/sh
#fixes xdg defaults to my preference

#determine a file's MIME type
#xdg-mime query filetype photo.jpg
#returns "image/jpeg"

#determine the default application for a MIME type
#xdg-mime query default image/jpeg
#returns "gimp.desktop" etc

#change the default application for a MIME type
xdg-mime default zathura.desktop application/pdf application/oxps application/epub_zip
xdg-mime default sxiv.desktop image/png image/jpeg
xdg-mime default mpv.desktop video/x-matroska video/mp4 video/x-msvideo video/webm video/x-flv video/quicktime video/x-ms-wmv video/MP2T application/x-mpegURL video/3gpp audio/aiff audio/midi audio/mpeg audio/mpeg3 audio/basic audio/wav
xdg-mime default qutebrowser.desktop text/html message/rfc822
xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop #seems to be a fix issues with http links resorting to other browsers

#be aware, $APPLICATION.desktop must exist in /usr/share/applications
#generally included with installation, but can also be manually made

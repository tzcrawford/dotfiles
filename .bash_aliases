alias ls='ls --color=auto --group-directories-first' 
alias ll='ls -la --color=auto --group-directories-first'
alias cls='clear && ls'
alias cll='clear && ll'
alias grep='grep --color=auto'
alias scim='sc-im'
alias sxiv='nsxiv'
alias youtube-dl="youtube-dl --add-metadata --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias youtube-dl720="youtube-dl -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias youtube-dl480="youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias yt-dlp="yt-dlp --add-metadata --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias yt-dlp720="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias yt-dlp480="yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias yt-dlp1080="yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' --output \"%(uploader)s - %(title)s.%(ext)s\" --write-srt --sub-lang en"
alias xclipb="xclip -selection clipboard"
alias pathof="readlink -zf"
alias mpvyt="mpv --ytdl-format='(bestvideo[height<=720]+bestaudio/best[height<=720])'"
alias sizes="du -sh * | sort -rh"

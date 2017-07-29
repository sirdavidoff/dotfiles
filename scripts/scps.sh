echo scp -r $1 sirdavidoff@actsofdavid.com:/home/sirdavidoff/$2
scp -r $1 sirdavidoff@actsofdavid.com:/home/sirdavidoff/$2 && growlnotify "Transfer complete" -m "$1 copied to server"
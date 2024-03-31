#!\bin/bash
#$Revision:001$
#$Sun Mar 31 05:38:53 UTC 2024$

#Variables
BASE=/home
DAYS=10
DEPTH=1
RUN=0

#Check if the directory is present or not
if [ ! -d $BASE ]
then
        echo "directory does not exist: $BASE"
        exit 1
fi

#create 'archive' folder if not present or not
if [ ! -d $BASE/archive ]
then
        mkdir $BASE/archive
fi

#Find the list of files largest than 20MB
for i in $(find $BASE -maxdepth $DEPTH -type f -size +20MB)
do
        if [ $RUN -eq 0 ]
        then
                echo "[$(date "+%Y-%m-%d %H:%M:%S")] archiving $i ==> $BASE/archive"
                gzip "$i" || exit 1
                mv "$i.gz" "$BASE/archive" || exit 1
        fi
done


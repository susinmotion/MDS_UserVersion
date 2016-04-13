#!/bin/bash
if [ ! -f secondtrie ]
then make||echo "Make failed. Do you have g++?"; exit
fi
python run.py||exit

if [ ! -f config.cfg]
then echo "Parameters file not set. Did you hit submit? Please try again"; exit
fi

head -n 2 config.cfg>tmp.cfg
source tmp.cfg
arr=$(echo $FILENAMES | tr "," "\n")
echo ${arr[*]}


if [ "$ZIPPED" = "True" ]
	then
		gunzip -c ${arr[*]} | ./secondtrie||echo "File not found. Check input file parameters."; exit

else
	for f in ${arr[*]}
    do
        echo "Processing $f"
        sed -i '' -e '$a\' $f
    done
    cat ${arr[*]} | ./secondtrie
fi
rm tmp.cfg

#!/bin/bash
export LANG=en_US.UTF-8
start=$PWD;
function tree {
    for dir in *
    do
        i=0
        for subdir in *
        do
            subdirs[$i]=$subdir 
            i=$i+1  
        done
        i=$i-1 
        if [ -d "$dir" ] ; then
            step=0
            while [ $step != $deep ]
            do
                printf "\u2502\u00A0\u00A0\u0020"
                step=$[$step+1]
            done
            if [ $dir = ${subdirs[i]} ] ; then
                printf "\u2514\u2500\u2500\u0020$dir"
                printf "\n" 
                last=1
            else
                printf "\u251c\u2500\u2500\u0020$dir"
                printf "\n" 
                last=0
            fi
            if cd "$dir" ; then
                deep=$[$deep+1]
                tree "$1"
                dirs=$[$dirs+1]
            fi
         else
             if [ $last = 0 ] ; then
                 step=0
                 while [ $step != $deep ]
                 do
                    printf "\u2502\u00A0\u00A0\u0020"
                    step=$[$step+1]  
                 done
             else
                 step=1
                 while [ $step -lt $deep ]
                 do
                    printf "\u2502\u00A0\u00A0\u0020"
                    step=$[$step+1]  
                 done
                 printf "\u0020\u0020\u0020\u0020"
             fi
             if [ $dir = ${subdirs[i]} ] ; then
                printf "\u2514\u2500\u2500\u0020$dir"
                printf "\n" 
                last=0
             else
                printf "\u251c\u2500\u2500\u0020$dir"
                printf "\n" 
             fi
             files=$[$files+1]
         fi
    done
    cd ..
    if [ "$deep" ] ; then
        end=1
    fi
    deep=$[$deep-1]
}
echo "."
end=0
deep=0
dirs=0
files=0
last=0
step=0
while [ "$end" != 1 ]
do
    tree "$1"
    cd $start
done
printf "\n"
if [ $dirs != 1 ] ; then
    echo -n $dirs "directories, "
else
    echo -n $dirs "directory, "
fi
if [ $files != 1 ] ; then
    echo $files "files"
else
    echo $files "file"
fi

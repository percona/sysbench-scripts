cat $1 | sed -e "s/\[\s*//" | sed -e "s/s\]//" | sed -e "s/ms//" | awk -v s=$2 ' /writes\/s/ { print s,$1,$9,$12 } ' | tr -d ","

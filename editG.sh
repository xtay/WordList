linesCount=`wc -l $1`

echo " "
echo "lines last updated: "
echo "$linesCount"
sed '$p' -n $1
echo " "
echo "[0:exit;1:direct insert;2:redo;3:abort]"
read -p "word: " word

while [ "$word" != "0" ]
do

	if [ "$word" == "1" ];then
		echo "Directly insert your word line:"
		read insert
	elif [ "$word" == "2" ];then
		sed '$p' -n $1
		sed '$d' -i $1
		echo "Redo the last one:"
		read insert
	else
		insert=`sdcv $word | grep -4 'XDICT' | sed "1,8d;s/^/$word /"`
		test -z "$insert" && read -p "NOT FOUND! do it yourself...$n" insert
	fi

	if [ "$insert" != "3" ];then
		echo $insert >> $1
		linesCount=`wc -l $1`
		echo "$linesCount"
		echo $insert
		echo " "
	fi

	echo "[0:exit;1:direct insert;2:redo;3:abort]"
	read -p "word: " word

done

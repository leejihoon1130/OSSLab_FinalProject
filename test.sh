#!/bin/bash

SAVE=$1

declare -a total_code
declare -a total_num
declare -a total_name
declare -a total_credit
declare -a total_time
declare -a total_room
declare -a total_grade
total_credit=0
number=0

while :
do
	temp=0
	echo "If there's no more, enter break"
	read -p "Class : " class
	echo ""

	if [ "$class" == "break" ]; then
		break
	fi

	overlap=0

	while IFS=, read -r code num name credit time room grade; do
		if [ "$code" == "$class" ]; then
			overlap=$(($overlap+1))

			echo "Code : $code"
			echo "Num : $num"
			echo "Name : $name"
			echo "Credit : $credit"
			echo "Time : $time"
			echo "Room : $room"
			echo "Evaluation Method : $grade"
			echo ""

			temp=1
		fi
	done < temp.csv

	if [ $overlap -gt 1 ]; then
		echo "********************"
		echo "There are more than two sections with the same code."
		echo "Please enter the section you want."
		read -p "Section : " section
		echo ""

		while IFS=, read -r code num name credit time room grade; do
			if [ "$code" == "$class" ] && [ "$num" == "$section" ]; then
				echo "Code : $code"
				echo "Num : $num"
				echo "Name : $name"
				echo "Credit : $credit"
				echo "Time : $time"
				echo "Room : $room"
				echo "Evaluation Method : $grade"
				echo ""

				temp=2
			fi
		done < temp.csv
	fi

	if [ $temp == "1" ]; then
		while IFS=, read -r code num name credit time room grade; do
			if [ "$code" == "$class" ]; then
				total_code+=("$code")
				total_num+=("$num")
				total_name+=("$name")
				total_credit+=("$credit")
				total_time+=("$time")
				total_room+=("$room")
				total_grade+=("$grade")

				temp_credit=$credit
			fi
		done < temp.csv
	elif [ $temp == "2" ]; then
		while IFS=, read -r code num name credit time room grade; do
			if [ "$code" == "$class" ] && [ "$num" == "$section" ]; then
				total_code+=("$code")
				total_num+=("$num")
				total_name+=("$name")
				total_credit+=("$credit")
				total_time+=("$time")
				total_room+=("$room")
				total_grade+=("$grade")

				temp_credit=$credit
			fi
		done < temp.csv	
	fi

	total_credit=$(expr $total_credit + $temp_credit)
	number=$(($number+1))
done

temp_overlap=0
i=0

while [ $i -lt $number ]; do
	j=$((i+1))
	while [ $j -lt $number ]; do
		if [ "${total_time[i]}" == "${total_time[j]}" ]; then
			temp_overlap=1
			break
		fi
		((j++))
	done
	((i++))
done

echo "Total credit : $total_credit"
echo "Number of classes : $number"
echo ""

if [ $temp_overlap == "1" ]; then
	echo "There are OVERLAPPED classes among the entered classes."
	echo "Please restart the program."
fi

echo ",Mon,Tue,Wed,Thu,Fri,Sat">final.csv
echo "1,m1,t1,w1,h1,f1,s1">>final.csv
echo "2,m2,t2,w2,h2,f2,s2">>final.csv
echo "3,m3,t3,w3,h3,f3,s3">>final.csv
echo "4,m4,t4,w4,h4,f4,s4">>final.csv
echo "5,m5,t5,w5,h5,f5,s5">>final.csv
echo "6,m6,t6,w6,h6,f6,s6">>final.csv
echo "7,m7,t7,w7,h7,f7,s7">>final.csv
echo "8,m8,t8,w8,h8,f8,s8">>final.csv
echo "9,m9,t9,w9,h9,f9,s9">>final.csv

cp final.csv $SAVE 

i=0
temp_name=0

while [ $i -lt $number ]; do
	if [ "${total_time[i]}" == "Mon6/Mon7" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m6|$temp_name|g" $SAVE
		sed -i "s|m7|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue7/Thu7" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t7|$temp_name|g" $SAVE
		sed -i "s|h7|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon7/Thu7" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m7|$temp_name|g" $SAVE
		sed -i "s|h7|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon1/Mon2/Thu2" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m1|$temp_name|g" $SAVE
		sed -i "s|m2|$temp_name|g" $SAVE
		sed -i "s|h2|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon6/Mon7/Thu6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m6|$temp_name|g" $SAVE
		sed -i "s|m7|$temp_name|g" $SAVE
		sed -i "s|h6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue1/Tue2/Fri2" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t1|$temp_name|g" $SAVE
		sed -i "s|t2|$temp_name|g" $SAVE
		sed -i "s|f2|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue5/Tue6/Fri6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t5|$temp_name|g" $SAVE
		sed -i "s|t6|$temp_name|g" $SAVE
		sed -i "s|f6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon2/Thu1/Thu2" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m2|$temp_name|g" $SAVE
		sed -i "s|h1|$temp_name|g" $SAVE
		sed -i "s|h2|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue2/Fri2" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|h2|$temp_name|g" $SAVE
		sed -i "s|f2|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue3/Fri3" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t3|$temp_name|g" $SAVE
		sed -i "s|f3|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon5/Thu5" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m5|$temp_name|g" $SAVE
		sed -i "s|h5|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon6/Thu6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m6|$temp_name|g" $SAVE
		sed -i "s|h6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon2/Thu2" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m2|$temp_name|g" $SAVE
		sed -i "s|h2|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon3/Thu3" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m3|$temp_name|g" $SAVE
		sed -i "s|h3|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon7/Mon8" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m7|$temp_name|g" $SAVE
		sed -i "s|m8|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue5/Tue6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t5|$temp_name|g" $SAVE
		sed -i "s|t6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue1/Tue2" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t1|$temp_name|g" $SAVE
		sed -i "s|t2|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon4/Thu4" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m4|$temp_name|g" $SAVE
		sed -i "s|h4|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Wed4" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|w4|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue6/Fri6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t6|$temp_name|g" $SAVE
		sed -i "s|f6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue4/Fri4" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t4|$temp_name|g" $SAVE
		sed -i "s|f4|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Wed8/Wed9" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|w8|$temp_name|g" $SAVE
		sed -i "s|w9|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue5/Fri5" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t5|$temp_name|g" $SAVE
		sed -i "s|f5|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Thu5/Thu6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|h5|$temp_name|g" $SAVE
		sed -i "s|h6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon5/Mon9/Thu5" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m5|$temp_name|g" $SAVE
		sed -i "s|m9|$temp_name|g" $SAVE
		sed -i "s|h5|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Tue6/Tue7/Fri6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|t6|$temp_name|g" $SAVE
		sed -i "s|t7|$temp_name|g" $SAVE
		sed -i "s|f6|$temp_name|g" $SAVE
	elif [ "${total_time[i]}" == "Mon5/Thu5/Thu6" ]; then
		temp_name="${total_name[i]}"
		sed -i "s|m5|$temp_name|g" $SAVE
		sed -i "s|h5|$temp_name|g" $SAVE
		sed -i "s|h6|$temp_name|g" $SAVE
	else
		echo "There is an ERROR among the entered classes."
	fi
	((i++))
done

while IFS=, read -r time m t w h f s; do
	length_m=${#m}
	length_t=${#t}
	length_w=${#w}
	length_h=${#h}
	length_f=${#f}
	length_s=${#s}

	if [ $length_m -eq 2 ]; then
		sed -i "s|$m|-|g" $SAVE
	fi

	if [ $length_t -eq 2 ]; then
		sed -i "s|$t|-|g" $SAVE
	fi

	if [ $length_w -eq 2 ]; then
		sed -i "s|$w|-|g" $SAVE
	fi

	if [ $length_h -eq 2 ]; then
		sed -i "s|$h|-|g" $SAVE
	fi

	if [ $length_f -eq 2 ]; then
		sed -i "s|$f|-|g" $SAVE
	fi

	if [ $length_s -eq 2 ]; then
		sed -i "s|$s|-|g" $SAVE
	fi
done < $SAVE


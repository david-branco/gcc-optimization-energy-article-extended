#!/bin/bash

#declare -a progs=("mmc" "grades" "bzip" "bzip2" "oggenc" "pbrt" "matmul" "PGo" "sudoku" "matmulobjc" "miscellany" "sorting")
declare -a progs=("prog" "sorting" "matmul" "grades" "mmc" "bzip" "bzip2")
declare -a flags=("-O0" "-O1" "-O2" "-Os" "-O3" "-Ofast")
#declare -a flags=("-O0")

gcc -O2 -Wall -o rapl-read rapl-read.c -lm

# for j in {1..10}
# do
	for PROG in "${progs[@]}"
	do
		echo "Analysing: $PROG"
		rm -rf outputs/$PROG
		mkdir outputs/$PROG

		for FLAG in "${flags[@]}"
		do
			mkdir outputs/$PROG/$FLAG
			perl -pi -e "s/^CFLAGS.*/CFLAGS = $FLAG/" source_files/$PROG/Makefile

			echo -e "\t$FLAG"
			if [ "$1" == "-e" ]; then 
				echo -e "\tCompiling $PROG"
				make -C source_files/$PROG/ &> outputs/$PROG/compilation$FLAG.txt
			fi

			for i in {1..100}
			do 
				printf "$i "
				if [ "$1" == "-e" ]
					then
						sudo ./rapl-read -c 1 -t -e source_files/$PROG/$PROG &> outputs/$PROG/$FLAG/output$i.txt
					else 
						sudo ./rapl-read -c 1 -t -m source_files/$PROG -s source_files/$PROG/$PROG.c &> outputs/$PROG/$FLAG/output$i.txt
				fi			
			done
			echo
		done
		echo
	done
# 	cp -r outputs/$PROG/ backup_outputs/$PROG/$j
# done

#perl charts.pl
#!/bin/bash

# Prompt the user to enter a number for the multiplication table
read -p "Enter a number for the multiplication table: " num

# To allow only numbers/integers
# ^: This is the start-of-line anchor. It asserts that the match must start at the beginning of the string.
# -? : matches an optional minus sign. It allows for both negative and positive numbers.
# [0-9] : matches any single digit from 0 to 9.
# + : matches one or more digits, ensuring that at least one digit is present.
# $: This is the end-of-line anchor. It asserts that the match must occur at the end of the string.

if [[ $num =~ ^-?[0-9]+$ ]]; then
	echo "You have entered the number $num"
else
	echo "Invalid input. Enter a number."
	read -p "Enter a number for the multiplication table: " num

fi

# Prompt the user to choose between a full or partial table

read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " table

# Check if the user chose a partial table
if [ "$table" = "p" ]; then
	read -p "Enter the starting number (between 1 and 10): " start

	read -p "Enter the ending number (between 1 and 10): " end


	# Check if the input is valid
	if ((start < 1 || start > 10 || end < 1 || end > 10 || start > end)); then 
		echo "Invalid input. Please enter numbers between 1 and 10, and ensure that the starting number is less than or equal to the ending number."
		echo "Showing full table instead."
		
		
		#Print full multiplication table of the initial number entered
		for i in {1..10}; do
			echo "$num x $i = $((num * i))"
                done
		exit 1
	fi

	
	# To display partial multiplication table
	echo "The partial multiplication table for $num from $start to $end:"
	
	for ((i = start; i <= end; i++)); do
		echo "$num x $i = $((num * i))"
	done


# Check if user chose full table
elif [ "$table" = "f" ]; then 
	echo "The multiplication table for $num:"

	#Print full multiplication table of the initial number entered
	for i in {1..10}; do
		echo "$num x $i = $((num * i))"
	done

# To handle invalid input for table choice
else 
	echo "Invalid input. Please enter 'f' for full or 'p' for partial."
	read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " table
fi



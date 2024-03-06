#!/bin/bash

# Get the current path from tmux
current_path=$(tmux display-message -p -F "#{pane_current_path}")

# Replace /home/USER/ with ~
formatted_path=${current_path/\/home\/$USER/\~}

# Function to truncate and add ellipsis in the middle if needed
truncate_path() {
	local path=$1
	local max_length=$2
	local part_length=$((max_length / 2 - 2))
	if [ ${#path} -gt $max_length ]; then
		echo "${path:0:$part_length}...${path: -$part_length}"
	else
		string_length=${#path}
		num_spaces=$((max_length - string_length))
		for ((i = 1; i <= num_spaces; i++)); do
			path+=" "
		done

		# echo "$max_length"
		# echo "$num_spaces"
		echo "$path"
		# printf "%-${max_length}s" "$path"
	fi
}

echo $(truncate_path "$formatted_path" 32)

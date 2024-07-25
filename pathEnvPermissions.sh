#!/bin/bash
#Checks for permissions on Path Variables, prints it out
IFS=':' read -r -a pathArray <<< "$PATH"

for dir in "${pathArray[@]}"; do
    if [ -d "$dir" ]; then
        current_perm=$(stat -c "%a" "$dir")
	echo "$dir: $current_perm"
    fi
done
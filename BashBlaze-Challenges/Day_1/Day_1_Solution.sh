#!/bin/bash

# The first line of the script is the shebang
# Task  1:Comments
# Comments are used to explain the code
# The shell ignores everything after a '#' on a line

# Task  2: Echo
echo "Hello I am writing a Script here!"

# Task  3: Variables
var1="Hey"
var2="Bash"

# Task  4: Using Variables
num="$var1, $var2!"
echo "$num"

# Task  5: Using Built-in Variables
echo "My current bash path - $BASH"
echo "Bash version I am using - $BASH_VERSION"
echo "PID of bash I am running - $$"
echo "My home directory - $HOME"
echo "Where am I currently? - $PWD"
echo "My hostname - $HOSTNAME"

# Task  6: Wildcards
# Create test files
mkdir -p test_dir
cd test_dir
touch a.txt b.txt c1.txt d2.log e.data f.pdf

# List all files
echo "All files:"
ls *

# List files with a single character in their name
echo -e "\nFiles with one character after 'c':"
ls c?.*

# List files starting with 'a', 'b', or 'c'
echo -e "\nFiles starting with 'a', 'b', or 'c':"
ls [abc]*

# List files that do not start with 'a', 'b', or 'c'
echo -e "\nFiles not starting with 'a', 'b', or 'c':"
ls [!abc]*

# Create multiple files using brace expansion
echo -e "\nCreating multiple files:"
touch file{1..5}.txt

# List all files again
echo -e "\nAll files after creation:"
ls *




#Make sure to provide execution permission with the following command:
#chmod +x day1_script.sh
#./day1_script.sh

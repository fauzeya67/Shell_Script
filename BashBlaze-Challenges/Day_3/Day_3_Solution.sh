#!/bin/bash

# Function to display help and usage information
usage() {
    echo "Usage: $0 [OPTION]"
    echo "User Account Management Script"
    echo
    echo "Options:"
    echo "  -c, --create           Create a new user account"
    echo "  -d, --delete           Delete an existing user account"
    echo "  -r, --reset            Reset password for an existing user account"
    echo "  -l, --list             List all user accounts"
    echo "  -h, --help             Display this help and exit"
    exit 1
}

# Function to create a new user account
create_account() {
    read -p "Enter new username: " username
    if id "$username" &>/dev/null; then
        echo "Error: User '$username' already exists!"
        exit 1
    else
        read -s -p "Enter password: " password
        echo
        sudo useradd -m "$username"
        echo "$username:$password" | sudo chpasswd
        echo "User '$username' created successfully."
    fi
}

# Function to delete an existing user account
delete_account() {
    read -p "Enter username to delete: " username
    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        echo "User '$username' deleted successfully."
    else
        echo "Error: User '$username' does not exist!"
        exit 1
    fi
}

# Function to reset password for an existing user
reset_password() {
    read -p "Enter username: " username
    if id "$username" &>/dev/null; then
        read -s -p "Enter new password: " password
        echo
        echo "$username:$password" | sudo chpasswd
        echo "Password for user '$username' reset successfully."
    else
        echo "Error: User '$username' does not exist!"
        exit 1
    fi
}

# Function to list all user accounts with UIDs
list_accounts() {
    echo "Listing all user accounts:"
    awk -F':' '{ print $1 " (UID: " $3 ")" }' /etc/passwd
}

# Parse command-line arguments
if [[ $# -eq 0 ]]; then
    usage
fi

case "$1" in
    -c|--create)
        create_account
        ;;
    -d|--delete)
        delete_account
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_accounts
        ;;
    -h|--help)
        usage
        ;;
    *)
        echo "Invalid option!"
        usage
        ;;
esac



# Make the Script Executable
chmod +x user_management.sh
# Run the Script
./user_management.sh [option]
#example usage
sudo ./user_management.sh -c  # To create a user
sudo ./user_management.sh -d  # To delete a user
sudo ./user_management.sh -r  # To reset a user's password
sudo ./user_management.sh -l  # To list all users






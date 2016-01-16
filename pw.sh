#! /bin/bash
# pw.sh 
# Bash script to force a user to change their password at next login on OS X

# Make sure script can only be ran on OS X
if [[ $(uname) != "Darwin" ]]; then
    echo "Script must be run on OS X!"
    exit 1
fi

adminuser=$1
user=$2

# Usage function
function usage() {
cat <<EOF
Usage: $0 [adminuser] [user-to-change]
    adminuser       The username of a user with admin rights
    user-to-change  The username of the user to force a password change on
    -h | --help     Display help
EOF

exit 1
}

# Validate command line arguments
if [[ $adminuser == "-h" || $adminuser == "--help" ]]; then
    # Check for -h or --help to display usage
    usage
elif [[ -z $adminuser || -z $user ]]; then
    # Make sure both command line arguments are at least filled if first is
    # not -h or --help
    usage
fi

# OS X specific command to force a user to change their password at next login
pwpolicy -a $adminuser -u $user -setpolicy "newPasswordRequired=1"

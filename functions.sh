# (C) 2014, Pedro I. López <dreilopz@gmail.com>
#
# This source code is released under the new BSD license, a copy of the
# license is in the distribution directory.

get_file_extensions() {
    find "${1-$(pwd)}" -type f -iname '*.*' | grep -iv -e '.*~' | 
    sed -e 's/.*\.\(.*\)/\1/' -e 's/\(.*\)/\L\1/' | sort | uniq
}

is_older() {
    age_threshold=${2-'0'}
    dirp=$(dirname ${1-$(pwd)})
    fp=$(basename ${1-$(pwd)})
    test "$(find "$dirp" -maxdepth 1 -mmin +$age_threshold -name "$fp")"
    return $?
}

get_named_dir() {
    if [ -z $1 ]
    then
        return 1
    fi
    fp="$1"
    maxdepth=${2-'1'}
    dirp=${3-$(pwd)}

    find "$dirp" -maxdepth "$maxdepth" -type d -name "$fp" 2>/dev/null |
        sort | head -n 1
}

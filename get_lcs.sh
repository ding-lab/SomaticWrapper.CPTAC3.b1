# Return the longest common path prefix
# Usage: 
#   bash get_lcs.sh /path/to/file1 /path/to/file2
# returns 
#   /path/to
# Both files should exist, warning if they do not

# To do: option to suppress existence check

if [ "$#" -ne 2 ]; then
    >&2 echo Error: Require 2 arguments
    exit 1
fi

if [ ! -e $1 ]; then
    >&2 echo Warning: File $1 does not exist
#    exit 1
fi

if [ ! -e $2 ]; then
    >&2 echo Warning: File $2 does not exist
#    exit 1
fi

# This incantation from https://unix.stackexchange.com/questions/67078/decomposition-of-path-specs-into-longest-common-prefix-suffix
printf "$1\n$2\n" | sed -e 's,$,/,;1{h;d;}' -e 'G;s,\(.*/\).*\n\1.*,\1,;h;$!d;s,/$,,'

# $Id: ~/lib/libandroid.sh wandsas 2018/08/15

# @Function: init_ccache <rel- or abs-path> <size> <optional max. size>
# arg1 relative or absolut path to ccache dir
# arg2 size of ccache
# arg3 max. size of the ccache (optional)
init_ccache () {
    local abspath=$1
    local size=$2

    export USE_CCACHE=1
    export CCACHE_DIR="$abspath"
    export CCACHE_SIZE="$size"
    # max. ccache
    ccache -M 50G
}


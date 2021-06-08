
# $1: path
# $*: parameter
function myenv_load_scripts()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	local dir=$1
	shift
	
	local opts="$*"
	
	for f in `find $dir -type f | sort`; do
		source $f $opts
	done

	return 0
}

# Just set path to bin
# $1: path
function myenv_load_bin_to_path()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	
	export PATH=$PATH:$1

	return 0
}

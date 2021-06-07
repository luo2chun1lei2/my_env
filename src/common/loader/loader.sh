
# $1: path
function myenv_load_scripts()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	
	for f in `find $1 -type f | sort`; do
		source $f
	done

	return 0
}

# $1: path
function myenv_load_bin()
{
	if [ ! -d $1 ]; then
		return 1
	fi
	
	export PATH=$PATH:$1

	return 0
}

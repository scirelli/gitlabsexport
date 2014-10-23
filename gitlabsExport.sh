#!/bin/bash
repos=/home/git/repositories/
output=/tmp/gitlabsexport/

mkdir -p "$output";
mkdir -p ~/repos;

check () {
	local c=${2:-0}
	if [ -d "$1" ]; then
		c=$(( $c+1 ))
		check "$1_$c" $c;
	else
		echo $1
	fi
}

for d in "$repos"*/*.git ; do
	folder=$(expr "$d" | grep -Po "[^/]+\.git?" | sed s/\.git$// )
	folderPath=$(check "$output$folder")
	echo "Running: git clone $d/ $folderPath"
	git clone "$d/" "$folderPath"
	tar -zcvf ~/repos/${folder}_$(date +%y-%m-%d).tar.gz $folderPath
	#break;
done

tar -zcvf ~/repos/bareRepos_$(date +%y-%m-%d).tar.gz $repos

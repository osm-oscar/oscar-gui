#!/bin/sh

declare -i N=0
for family in $*; do
	for agent in \
		'Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0' ;
	do
		((N=N+1))
		# See https://developers.google.com/fonts/docs/getting_started for api urls
		curl -A "$agent" -s "http://fonts.googleapis.com/css?family=$family" | \
		sed -n '/^\/\* latin \*\/$/,/^}$/p' | tee ${N}.css | grep -oE 'url\([^)]+\)'
	done | sort -u | \
	while read src; do
		src=${src%%)}
		url=${src##url(}
		src=${src%%\'), url(*}
		file=${url##http://*/}
		echo $file;
		curl -s "$url" -o "$file";
	done
done
for css in $(ls *.css | grep -E '^[0-9]+.css$'); do
	sed -i -e 's#http://.*/#../webfonts/#' $css
	# comment the next line when fetching Material+Icons
	sed -i -e '/^\/\* latin \*\/$/d' $css
	format=$(grep -m 1 -oE 'format\([^)]+\)' $css | sed -e "s/format('\(.*\)')/\1/")
	mv $css ${format}.css
done

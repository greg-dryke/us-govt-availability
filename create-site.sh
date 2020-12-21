#!/bin/bash

template="index.html_template"
index="index.html"
down_days_url="https://raw.githubusercontent.com/greg-dryke/us-govt-availability/trunk/down_days.txt"

content=$(cat $template)

now=$(date +%s)
govt_start=$(date -d 'dec 1 1789' +%s)
days_since=$(( (now - govt_start) / 86400 ))

days_down=$(curl -s $down_days_url)

avail=$(perl -e "printf \"%.7f\", ((($days_since-$days_down) / $days_since) * 100.0000000)")

echo $content | sed  s/%%AVAILABILITY%%/$avail/g > $index

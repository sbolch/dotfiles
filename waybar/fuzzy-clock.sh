#!/usr/bin/env bash
set -u

words=(zero one two three four five six seven eight nine ten eleven twelve)
h=$(date +%-H)
m=$(date +%-M)
hm=$(date +%-I)
nm=$(( (h + 1) % 12 ))
[ "$nm" -eq 0 ] && nm=12

if [ "$m" -eq 0 ]; then
	fuzzy="${words[$hm]} o'clock"
elif [ "$m" -le 7 ]; then
	fuzzy="just past ${words[$hm]}"
elif [ "$m" -le 12 ]; then
	fuzzy="ten past ${words[$hm]}"
elif [ "$m" -le 17 ]; then
	fuzzy="quarter past ${words[$hm]}"
elif [ "$m" -le 22 ]; then
	fuzzy="twenty past ${words[$hm]}"
elif [ "$m" -le 27 ]; then
	fuzzy="half past ${words[$hm]}"
elif [ "$m" -le 32 ]; then
	fuzzy="twenty five past ${words[$hm]}"
elif [ "$m" -le 37 ]; then
	fuzzy="twenty five to ${words[$nm]}"
elif [ "$m" -le 42 ]; then
	fuzzy="quarter to ${words[$nm]}"
elif [ "$m" -le 47 ]; then
	fuzzy="ten to ${words[$nm]}"
elif [ "$m" -le 52 ]; then
	fuzzy="twenty to ${words[$nm]}"
elif [ "$m" -le 57 ]; then
	fuzzy="almost ${words[$nm]}"
else
	fuzzy="nearly ${words[$nm]}"
fi

day=$(LC_ALL=C date +%A)
tooltip=$(date '+%Y-%m-%d %H:%M')
printf '{"text": "%s - %s", "tooltip": "%s"}\n' "$day" "${fuzzy^}" "$tooltip"

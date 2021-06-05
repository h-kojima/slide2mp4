#!/bin/bash
#
# Copyright (C) 2021 Hirofumi Kojima
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LEXICON_FILE="$1"
DIC_TXT="$2"


print_usage ()
{
	echo "Description:"
	echo "	$(basename $0) converts a lexicon file to a dictionary file."
	echo "Usage:"
	echo "	$(basename $0) LEXICON_FILE DIC_TXT"
	exit
}


if [ $# -ne 0 ]; then
	if [ "$1" == "-h" ]; then
		print_usage
	elif [ "$1" == "--help" ]; then
		print_usage
	fi
fi
if [ $# -ne 2 ]; then
	echo "Too few or many arguments. Please check whether the number of arguments is 2."
	echo "Please check '$(basename $0) -h' or '$(basename $0) --help'."
	exit
fi


cat "$LEXICON_FILE" |grep -e "<grapheme>" -e "<alias>" > tmp-LEXICON_FILE.txt


wi=0; wj=0; count=0
while read line
do
	check_grapheme=$(echo "$line" |grep grapheme 2> /dev/null)
	if [ -n "$check_grapheme" ]; then
		wi=$(($wi+1)); count=$(($count+1))
		word[wi]=$(echo "$line" |sed -e "s/<\/*grapheme>//g" -e "s/ //g")
	else
		wj=$(($wj+1))
		alias[wj]=$(echo "$line" |sed -e "s/<\/*alias>//g" -e "s/ //g")
		word_count[wj]=$count; count=0
	fi
done < tmp-LEXICON_FILE.txt
rm -f tmp-LEXICON_FILE.txt


echo "# word	pronunciation" > "$DIC_TXT"
echo >> "$DIC_TXT" 
wj=1
for i in ${!word[@]}
do
	printf "${word[$i]}\t${alias[$wj]}\n" >> "$DIC_TXT"
	word_count[wj]=$((${word_count[$wj]}-1))
	if [ ${word_count[$wj]} -eq 0 ]; then
		wj=$(($wj+1))
	fi
done

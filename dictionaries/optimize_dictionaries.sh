#!/bin/bash
## Removes unnecessary spaces and tabs from dictionaries
if [[ ${PWD##*/} == 'dictionaries' ]]; then
 sed 's/[[:blank:]]*$//' adjectives.txt > adjectives_new.txt
 sed 's/[[:blank:]]*$//' nouns.txt > nouns_new.txt
 rm adjectives.txt nouns.txt
 mv adjectives_new.txt adjectives.txt
 mv nouns_new.txt nouns.txt
 echo "Done!"
else
 echo "Make sure that you're inside the 'dictionaries' directory!"
fi

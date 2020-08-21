#!/bin/bash
VERSION='1.0.0-Bash'
AUTHOR='oliwier975PL & workonfire'

echo -ne "\033]0;GSN\007"

echo -e "\e[97m         (        )  "
echo -e "\e[93m (       )\\ )  ( /(  "
echo -e "\e[33m )\\ )   (()/(  )\\()) "
echo -e "\e[91m(()/(    /(_))((_)\\  "
echo -e "\e[31m /(_))_ (_))   _((_) "
echo -e "\e[31m(_)) __|/ __| | \\| | "
echo -e "\e[31m  | (_ |\\__ \\ | .\` | "
echo -e "\e[31m   \\___||___/ |_|\\_| "
echo "Generator Spierdolonych Nicków v${VERSION}"
echo -e "\e[93mby ${AUTHOR}\e[39m\n"

while true; do
 echo -n "Ilość nicków do wygenerowania: "
 read how_many_times
 
 if [[ $how_many_times =~ ^[0-9] ]]; then
  break
 fi
 
 echo -e "\e[31mPodaj poprawne wartości.\e[39m"
done

if [[ $how_many_times -eq '69' ]]; then
 echo -e "\e[91m▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
 echo -e "\e[93m██ ███ █▄▄ ██▄██ ██ █ ▄▀▄ ██"
 echo -e "\e[92m██ █ █ █▀▄███ ▄█ ██ █ █▄█ ██"
 echo -e "\e[94m██▄▀▄▀▄█▄▄▄█▄▄▄██▄▄▄█▄███▄██"
 echo -e "\e[95m▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\e[39m"
fi

while true; do
 echo -n "Maksymalna ilość znaków: "
 read max_length

 if [[ $max_length =~ ^[0-9] ]]; then
  break
 fi

 echo -e "\e[31mPodaj poprawne wartości.\e[39m"
done

echo -e "\e[31mUWAGA: Jeśli jakieś nicki będą przekraczały ustalony limit znaków, zostaną one przycięte.\e[39m"

echo -n "Zapisać wynik do pliku? (y/N): "
read save_to_file

echo -n "Doklejać losową liczbę? (y/N): "
read generate_number

echo -n "Usunąć polskie znaki? (y/N): "
read strip_polish_chars

readarray -t adjectives < dictionaries/adjectives.txt
readarray -t nouns < dictionaries/nouns.txt

generated_nicknames=()
echo -e "Generowanie nicków...\n"

for ((i=1; i<=how_many_times; i++)); do
 adjective=$(echo "${adjectives[$(($RANDOM % ${#adjectives[@]}))]}")
 noun=$(echo "${nouns[$(($RANDOM % ${#nouns[@]}))]}")
 if [[ $(($RANDOM % 2)) -eq 1 ]]; then
  noun="_${noun}"
 else
  noun="${noun^}"
 fi
 generated_nick="${adjective}${noun}"
 if [[ ${generate_number,} == 'y' ]]; then
  generated_nick="${generated_nick}$(($RANDOM % 100 + 1))"
 fi
 if [[ ${#generated_nick} -gt $max_length ]]; then
  generated_nick="${generated_nick:0:$max_length}"
 fi
 if [[ ${strip_polish_chars,} == 'y' ]]; then
  generated_nick=$(echo "$generated_nick" | iconv -f utf-8 -t ascii//translit)
 fi
 generated_nicknames+=( $generated_nick )
 echo -e "\e[96m> $generated_nick"
done

echo -e "\n\e[92mGotowe."

if [[ ${save_to_file,} == 'y' ]]; then
 printf '%s\n' "${generated_nicknames[@]}" > output.txt
 echo -e "\e[92mZapisano nicki do pliku."
fi

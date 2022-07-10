#!/bin/bash

path=$(pwd)
file="/root/M2-Availability/mail_info.txt"
file_path="--upload-file mail.txt"
while read -r line; do
	
	if [[ -n $line ]]; then
		if [[ $line == *"smtp"* ]]; then
			smtp=$(echo "$line" | awk -F "=" '{ print $2 }')
			printf "smtp: $smtp\n"
			#send_email="$send_email '$smtp"

		elif [[ $line == *"receiver"* ]]; then
			rec=$(echo "$line" | awk -F "=" '{ print $2 }')
			printf "receiver: $rec\n"
			mail_rcpt="$mail_rcpt --mail-rcpt ${rec}"

		elif [[ $line == *"port"* ]]; then
			port=$(echo "$line" | awk -F "=" '{ print $2 }')
			printf "port: $port\n"
			#send_email="$send_email:$port'"

		elif [[ $line == *"sender"* ]]; then
			sender=$(echo "$line" | awk -F "=" '{ print $2 }')
			printf "sender: $sender\n"
			#send_email="$send_email"
		
		elif [[ $line == *"password"* ]]; then
			password=$(echo "$line" | awk -F "=" '{ print $2 }')
			printf "sender password: $password\n"
		
		elif [[ $line == *"from"* ]]; then
			from=$(echo "$line" | awk -F "=" '{ print $2 }')
			printf "from: $from\n"
		fi	
	fi
done <$file

printf "$mail_rcpt\n"
echo ""
echo ""
curl \
	--ssl-reqd --url "smtp://${smtp}:${port}" \
 	--user "${sender}:${password}" \
	--mail-from "${from}" \
	$mail_rcpt \
	--upload-file ~/M2-Availability/mail.txt

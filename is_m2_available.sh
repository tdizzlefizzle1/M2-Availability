#!/bin/bash

#test_list="https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLY33LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD0F,065-CD5W&fts=true https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLY13LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD0D,065-CD5W&fts=true https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLXW3LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD09,065-CD5W&fts=true https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLXY3LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD0C,065-CD5W&fts=true"

m2_midnight=$(curl -s -X GET 'https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLY33LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD0F,065-CD5W&fts=true' | jq '.body | .content | .deliveryMessage | ."MLY33LL/A" | "\(.isBuyable)"')

m2_starlight=$(curl -s -X GET 'https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLY13LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD0D,065-CD5W&fts=true' | jq '.body | .content | .deliveryMessage | ."MLY13LL/A" | "\(.isBuyable)"')

m2_spacegray=$(curl -s -X GET 'https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLXW3LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD09,065-CD5W&fts=true' | jq '.body | .content | .deliveryMessage | ."MLXW3LL/A" | "\(.isBuyable)"')

m2_silver=$(curl -s -X GET 'https://www.apple.com/us-edu/shop/fulfillment-messages?little=false&mt=regular&parts.0=MLXY3LL/A&option.0=065-CCJT,065-CCJW,065-CCJY,065-CCM2,065-CCLY,065-CCM1,065-CCM0,065-CD7F,065-CD0C,065-CD5W&fts=true' | jq '.body | .content | .deliveryMessage | ."MLXY3LL/A" | "\(.isBuyable)"')

avail_list="M2_Midnight_Base M2_Starlight_Base M2_SpaceGray_Base M2_Silver_Base"
arr=($avail_list)
num=0

echo -e "Hey, $(whoami)!\nI have the search results for the latest MacBook M2 Airs:"
for j in $m2_midnight $m2_starlight $m2_spacegray $m2_silver; do
	if [[ $j != '"false"' ]]; then
		python3 ~/M2-Macbook-Availability/sms.py
		exit
	else
		printf "Is \e[1m${arr[num]}\e[0m available?: \e[31m\e[4m\e[1mNo\e[0m\n"

	fi
	((num=num+1))
done
echo ""

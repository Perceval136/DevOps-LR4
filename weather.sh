#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 <city>"
    exit 1
fi

CITY=$1
OUTPUT_FILE="/var/www/html/index.html"

WEATHER_DATA=$(curl -s "wttr.in/${CITY}?format=j1")
TEMP=$(echo "$WEATHER_DATA" | jq -r '.["current_condition"][0].temp_C')
HUM=$(echo "$WEATHER_DATA" | jq -r '.["current_condition"][0].humidity')
CURRENT_DATE=$(date '+%d.%m.%Y %H:%M:%S')

cat > "$OUTPUT_FILE" << EOF
<HTML>
<HEAD>
    <TITLE>Weather in $CITY</TITLE>
    <meta http-equiv="refresh" content="60">
</HEAD>
<BODY>
    <h1>City: $CITY</h1>
    <p><strong>Temp:</strong> $TEMP</p>
    <p><strong>Hum:</strong> $HUM</p>
    <p><strong>Last update:</strong> $CURRENT_DATE</p>
</BODY>
</HTML>
EOF

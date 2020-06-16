searchAndDestroy() {

  lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9

  echo "Port" $1 "found and killed."

}


#!/bin/bash

map_test() {
  local -A my_map=()
  while read -r line; do
      if [[ "${my_map["$line"]}" == "true" ]]; then
        echo "already done: $line"
        continue
      fi
#    echo $line
    my_map["$line"]=true

  done < <(rg -N -I -o --pcre2 '(?<=image: ).+' rendered | sed "s/^\s+$//g")
}

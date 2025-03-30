#!/usr/bin/env bash

all_pics_dir="$1"
async="$2"

pic_stats() {
  local total subtotal
  total=0
  root_total="$(fd -d1 "jpg|png|gif|tif" "$all_pics_dir" | wc -l)"
  echo "ROOT: $root_total"
  total=$(( total + root_total ))
  while IFS= read -r dir; do
    subtotal="$(fd "jpg|png|gif|tif" "$dir" | wc -l)"
    echo "$(basename "$dir"): $subtotal"
    total=$(( total + subtotal ))
  done < <(fd -t d "" "$all_pics_dir")
  echo "TOTAL: $total"
}

echo """
BEFORE
------
$(pic_stats)

"""

rm -rf VideoCapture*
rm -rf Snapchat*
rm -rf Screenshot*

while IFS= read -r image; do

  process(){
    categorized="false"
    # extract year
    if year="$(exiftool -DateTimeOriginal "$image" | awk '{print $4}' | cut -d':' -f1)"; then
      image_name="$(basename "$image")"
      # check year is valid integer
      if [[ "$year" =~ ^2[0-9]{3}$ ]]; then
        mkdir -p "$all_pics_dir/$year"
        if [[ ! -e "$all_pics_dir/$year/$image_name" ]]; then
          if mv "$image" "$all_pics_dir/$year"; then
            echo "Moved image $image_name: $year"
            categorized="true"
          else
            echo "Failed to move image $image_name: $year"
          fi
        else
          echo "Image already processed: $image"
          rm "$image"
          categorized="true"
        fi
      fi
    fi

    # move to uncategorized if necessary
    if [[ "$categorized" == "false" ]]; then
      if [[ ! -e "$all_pics_dir/0000/$image_name" ]]; then
        if mv "$image" "$all_pics_dir/0000"; then
          echo "Uncategorized image $image_name"
        fi
      else
        echo "Image already processed: $image"
        rm "$image"
      fi
    fi
  }
  if [[ -n "$async" ]]; then
    process &
  else
    process
  fi
done < <(fd -d1 "jpg|png|gif|tif" "$all_pics_dir")

echo """

AFTER
-----
$(pic_stats)
"""

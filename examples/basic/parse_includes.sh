#!/bin/bash

file=$1
shift
search_dirs=$@

deps=""
function find_deps() {
  local lib_file="$1"
  if [[ ! $deps =~ $lib_file ]]; then
    deps="$deps $lib_file"
    local included_headers=$(grep -oP '#include\s*"\K[^"]+' "$lib_file")
    for header in $included_headers; do
      for dir in $search_dirs; do
        local lib_c_file=$(find "$dir" -name "${header%.*}.c")
        if [ -f "$lib_c_file" ]; then
          find_deps "$lib_c_file"
        fi
      done
    done
  fi
}

included_headers=$(grep -oP '#include\s*"\K[^"]+' "$file")

for header in $included_headers; do
  for dir in $search_dirs; do
    lib_c_file=$(find "$dir" -name "${header%.*}.c")
    if [ -f "$lib_c_file" ]; then
      find_deps "$lib_c_file"
    fi
  done
done

echo $deps

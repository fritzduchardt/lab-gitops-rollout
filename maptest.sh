#!/bin/bash

source ./maptest_lib.sh


nested() {
  localfunc() {
    for var in one two; do
      echo "Interation: $var"
      map_test
    done
  }
  localfunc
}
nested

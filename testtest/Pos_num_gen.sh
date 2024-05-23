#!/bin/bash
s=$((RANDOM % 99+1))

echo "scale=2 ; $s / 100" | bc 



#!/bin/bash
ps -eo "%p %G %U %c %a"|awk -F" " '{print $1,$2,$3,$4,$5}'
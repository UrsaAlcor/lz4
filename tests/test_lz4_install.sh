
alcor init .
alcor activate --auto

alcor install lz4 --url 
module load lz4

gcc lz4_main.c -o lz4_main -llz4

rm pzip 
gcc -o pzip zip-mmap.c -Wall -Werror -O
./test-time.sh 
valgrind --leak-check=full ./pzip tests/1.in
echo
valgrind --leak-check=full ./pzip tests/6.in > /dev/null

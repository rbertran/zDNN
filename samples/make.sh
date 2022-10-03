set -e
set -x
cd ..
make -j
cd -

for elem in *.c ; do
    gcc -Werror -Wall -O3 -march=z15 -fmessage-length=0 -std=c99 -I ../zdnn -o ${elem/%.c/} ${elem}  ../zdnn/lib/libzdnn.a -D STATIC_LIB -lm
    if [ "$elem" = "rnn_lstm_multi_layers.c" ]; then continue; fi;
    for rep in $(seq 1 100); do
        ./${elem/%.c/} 100
    done;
done

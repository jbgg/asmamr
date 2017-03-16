#!/bin/sh

cd "${SCRIPTS}/asm"

ARM_DIR_BIN=${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin

CC=${ARM_DIR_BIN}/arm-linux-androideabi-gcc

OD=${ARM_DIR_BIN}/arm-linux-androideabi-objdump


if [ "$#" -le '0' ]
then
   echo "usage: $0 'instruction1;instruction2;...'"
   exit
fi

n=0
tmpo="tmp${n}.o"

while [ -e "$tmpo" ]
do
    n=`expr ${n} + 1`
    tmpo="tmp${n}.o"
done

echo "\t.text\n$1" |  ${CC} -x assembler -march=armv7-a -c - -o ${tmpo}

if [ "$?" -ne 0 ]
then
    echo "error: CC"
    exit
fi

${OD} -j .text -d ${tmpo} | tail -n +7

rm ${tmpo}

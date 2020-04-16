#!/bin/bash

# OBS: o arquivo de hosts.txt precisa ter EXATAMENTE 1 linha branca no final, senao coisas dao errado

shopt -s extglob
set -o pipefail

rm -f available_hosts
mkfifo available_hosts

if [[ ! -f hosts.txt ]]; then
    echo Missing hosts.txt file!
    exit 1
fi

while read hostinput; do
    echo "writing $hostinput to available_hosts"
    echo "$hostinput" > available_hosts
    sleep 1
done < hosts.txt &


sleep 1

function add_available_host(){
    echo "$host" > available_hosts || true
}

# try 3 times to catch the errored files, now ignoring the shitty hosts
for i in {0..2}; do
    for file in !(*HEVC*).mkv; do
        echo trying to encode $file
        

        output_file="$(echo "$file" | sed 's/.mkv/_HEVC.mkv/')"

        # pula esse arquivo se ele ja existe e nao deu erro ou se está processando
        if [[ -f "$output_file" && ! -f "$file.error" ]]; then
            echo $file already done, skipping! 
            continue
        elif [[ -f "$file.processing" ]]; then
            echo $file is still processing, skipping! 
            continue
        fi

        host="$(head -n 1 available_hosts)"

        touch "$file.processing" &&
            set -o pipefail && cat "$file" | ssh "$host" "ffmpeg -i - -map 0 -c copy -c:v libx265 -pix_fmt yuv420p10le -crf 32 -preset veryslow -c:a libopus -b:a 80K -vbr on -compression_level 10 -af aformat=channel_layouts=\"7.1|5.1|stereo\" -ac 2 -f matroska -" > "$output_file" &&
            touch "$file.finished" &&
            rm -f "$file.error" &&
            rm -f "$file.processing" &&
            (timeout 2 bash -c "echo \"$host\" > available_hosts" || true) || (touch "$file.error" && rm -f "$output_file" && rm -f "$file.processing")  &

        sleep 3
    done
done


# for file in !(*HEVC*).mkv.error; do
#     file="$(echo "$file" | sed 's/.mkv.error/.mkv/')"
#     echo trying again for file $file
#     encode
#     sleep 3
# done


# remove .error for files that are .finished
for file in !(*HEVC*).mkv.finished; do
    rm -f "$(echo "$file" | sed 's/.finished/.error/')"
done

wait

echo Finished!
#----------------------------

# while read hostinput; do
#     echo "writing $hostinput to available_hosts"
#     echo "$hostinput" > available_hosts
#     sleep 1
# done < hosts.txt &


# sleep 1

# for file in !(*HEVC*).mkv; do

#     host="$(head -n 1 available_hosts)"
#         echo Running $file in $host &&
#         sleep 3 &&
#         echo finished $file on $host &&
#         echo "$host" > available_hosts &
# done

#----------------------------
# hosts=($(cat hosts.txt))

# available_hosts=(${hosts[@]})
# for file in !(*HEVC*).mkv; do
#     while [[ ${#available_hosts[@]} == "0" ]]; do
#         echo Waiting for available hosts...
#         sleep 1
#     echo available_hosts: ${available_hosts[@]}
#     done
#     host="${available_hosts[0]}"
#     available_hosts=(${available_hosts[@]/$host})
#     echo Running $file in $host &&
#         sleep 3 &&
#         echo finished $file on $host &&
#         available_hosts+=($host) & 
# done


#!/bin/sh

if [ -z "$1" ];then
        cat <<EOF
___urror___

Kasutamine: skript.sh metric
EOF
        exit 1
fi

export SCRIPT_NAME=/php-fpm_status
export SCRIPT_FILENAME=/php-fpm_status
export QUERY_STRING=
export REQUEST_METHOD=GET
METRIC="$1"



## output metrics
case $METRIC in
        pool)
                cgi-fcgi -bind -connect 127.0.0.1:9000  | grep "^pool:"| cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        process_manager)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^process manager:"| cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        start_time)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^start time:"| sed 's|^start time:\s\+||'
                ;;
        start_since)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^start since:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        accepted_conn)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^accepted conn:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        listen_queue)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^listen queue:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        max_listen_queue)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^max listen queue:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        listen_queue_len)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^listen queue len:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        idle_processes)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^idle processes:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        active_processes)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^active processes:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        total_processes)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^total processes:" | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        max_active_processes)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^max active processes:"  | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        max_children_reached)
                cgi-fcgi -bind -connect 127.0.0.1:9000 | grep "^max children reached:"  | cut -d ":" -f 2 | sed 's|^\s\+||'
                ;;
        *)
                echo "Unsupported metric $METRIC"
                exit 1
        ;;
esac

exit 0


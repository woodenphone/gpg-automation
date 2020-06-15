#!/bin/bash
#
# This.
# Is.
# Awful.

# write that file as:
# round=<0|1|2>
# oldpass=1234
# newpass=4321

# Borrowed from https://github.com/ecraven/pinentry-emacs/blob/master/pinentry-emacs

IPCFILE="$TMP/.some_pretend_ipc"

if ! [ -e "${IPCFILE}" ]
then
    exit 10
else
    status=$(awk -F= '/round=/ {print $2}' <"${IPCFILE}")
fi

echo OK
while read cmd rest
do
    case $cmd in
        SETDESC)
            DESC=$rest
            echo OK
        ;;
        SETPROMPT)
            PROMPT=$rest
            echo OK
        ;;
        SETOK)
            OK=$rest
            echo OK
        ;;
        SETERROR)
            ERROR=$rest
            echo OK
        ;;
        GETPIN)
            if [ $status -eq 0 ]
            then
                OLDPIN=$(awk -F= '/oldpin=/ {print $2}' <"${IPCFILE}")
                echo "D ${OLDPIN}"
                sed -i -e 's/round=0/round=1/' "${IPCFILE}"
            elif [ $status -gt 0 ]
            then
                NEWPIN=$(awk -F= '/newpin=/ {print $2}' <"${IPCFILE}")
                echo "D ${NEWPIN}"
                [ $status -eq 1 ] && sed -i -e 's/round=1/round=2/' "${IPCFILE}"
            fi
            echo OK
        ;;
        OPTION)
            echo OK
        ;;
        GETINFO)
            case $rest in
                pid*)
                    echo D $$
                    echo OK
                ;;
            esac
        ;;
        BYE)
            echo OK
            exit
        ;;
        *)
            echo OK
        ;;
    esac
done

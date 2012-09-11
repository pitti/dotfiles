#/!bin/sh

MACHINE=$(basename "$0" | cut -s -f2- -d-)
WINUSER=philippi
RESOLUTION=1276x1000


# check VM RDP port
wait=1
while ! nc -w 1 -z $MACHINE.ddns.lcl 3389; do
	echo "Waiting for host $MACHINE.ddns.lcl to open port 3389."
	sleep $wait
done

exec xfreerdp -0 -a 32  -x l \
           --sec rdp \
           -g $RESOLUTION \
           --gdi hw \
           -k 0x00010407 \
           -d TRANSPORTATION -u $WINUSER \
           --plugin rdpsnd \
           --plugin cliprdr \
           --plugin drdynvc \
             --data audin:alsa tsmf:audio:alsa -- \
           --plugin rdpdr   \
             --data disk:home:/home/$USER printer:PDF \
                    disk:tmp:/tmp -- \
           $MACHINE.ddns.lcl

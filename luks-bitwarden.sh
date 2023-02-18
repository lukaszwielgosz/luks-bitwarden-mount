BLOCK_DEVICE=/dev/sda1
NAME=encrypted
MOUNT_PATH=/mnt/encrypted

SERVER_URL=https://bitwarden.example.com
LOGIN=username@example.com
PASSWORD=bitwarden_password
ITEM_ID=99ee88d2-6046-4ea7-92c2-acac464b1412
BW=/usr/local/bin/bw # (default) path to bw binary

$BW config server $SERVER_URL
$BW logout
BW_SESSION=$($BW --nointeraction --raw login $LOGIN $PASSWORD)
BW_SESSION=$($BW --nointeraction --raw unlock $PASSWORD)
LUKS_PASSPHRASE=$($BW --nointeraction --session $BW_SESSION get password $ITEM_ID)

echo -n $LUKS_PASSPHRASE | cryptsetup luksOpen $BLOCK_DEVICE $NAME -d -
mount /dev/mapper/$NAME $MOUNT_PATH


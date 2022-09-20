#!/sbin/sh

#####################################
# Emoji iOS 15.4       #
#          By                       #
# IslamAlOrabi (t.me/IslamAlOrabi) #
#####################################

FONT_DIR=$MODPATH/system/fonts
DEF_EMOJI="NotoColorEmoji.ttf"


# Replace faceook & messnger emojis
fb_msg_emoji() {
    DATA_DIR="/data/data/"
    EMOJI_DIR="app_ras_blobs"
    TTF_NAME="FacebookEmoji.ttf"
    apps='com.facebook.orca com.facebook.katana'
    for i in $apps ; do  # NOTE: do not double-quote $services here.
        if [ -d "$DATA_DIR$i" ]; then
            cd $DATA_DIR$i
            if [ ! -d "$EMOJI_DIR" ]; then
                mkdir $EMOJI_DIR
            fi
            cd $EMOJI_DIR

            APP_NAME="Facebook"
            if [[ $i == *"orca"* ]]; then
                APP_NAME="Messenger"
            fi

            # Change
            if cp $FONT_DIR/$DEF_EMOJI ./$TTF_NAME; then
                TTF_PATH="${DATA_DIR}${i}/${EMOJI_DIR}/${TTF_NAME}"
                set_perm_recursive $TTF_PATH 0 0 0755 700
                ui_print "- Replacing $APP_NAME Emojis ✅"
            else
                ui_print "- Replacing $APP_NAME Emojis ❎"
            fi
        fi
    done
}

# Replace System Emoji
system_emoji(){
    ui_print "- Replacing $DEF_EMOJI ✅"
    emojis='SamsungColorEmoji.ttf AndroidEmoji-htc.ttf ColorUniEmoji.ttf DcmColorEmoji.ttf CombinedColorEmoji.ttf'
    for i in $emojis ; do
        if [ -f "/system/fonts/$i" ]; then
            cp $FONT_DIR/$DEF_EMOJI $FONT_DIR/$i && ui_print "- Replacing $i ✅" || ui_print "- Replacing $i ❎"
        fi
    done
}

system_emoji
fb_msg_emoji
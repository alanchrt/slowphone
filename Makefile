.PHONY: slow fast

all: slow

slow:
	adb root
	sleep 3
	adb shell mkdir -p /sdcard/slow-backup
	adb shell mount -o rw,remount /system
	adb shell mv -n /system/app/Gello /system/app/messaging /system/app/Email /system/app/Calendar /system/priv-app/Trebuchet /system/priv-app/GoogleFeedback /etc/hosts /sdcard/slow-backup/ || true
	adb push etc/hosts /etc/hosts
	adb reboot

fast:
	adb root
	sleep 3
	adb shell mount -o rw,remount /system
	adb shell mv -n /sdcard/slow-backup/Gello /sdcard/slow-backup/messaging /sdcard/slow-backup/Email /sdcard/slow-backup/Calendar /system/app/ || true
	adb shell chown -R root:root /system/app/Gello /system/app/messaging /system/app/Email /system/app/Calendar
	adb shell chmod 755 /system/app/Gello /system/app/messaging /system/app/Email /system/app/Calendar
	adb shell chmod 644 /system/app/Gello/* /system/app/messaging/* /system/app/Email/* /system/app/Calendar/*
	adb shell mv -n /sdcard/slow-backup/Trebuchet /sdcard/slow-backup/GoogleFeedback /system/priv-app/ || true
	adb shell chown -R root:root /system/priv-app/Trebuchet /system/priv-app/GoogleFeedback
	adb shell chmod 755 /system/priv-app/Trebuchet /system/priv-app/GoogleFeedback
	adb shell chmod 644 /system/priv-app/Trebuchet/* /system/priv-app/GoogleFeedback/*
	adb shell mv /sdcard/slow-backup/hosts /etc/hosts || true
	adb reboot

hosts:
	adb push etc/hosts /etc/hosts

#!/system/bin/sh

# Set permissions
chmod 0664 /sys/class/devfreq/vdsp/* 2>/dev/null
chmod 0664 /sys/class/devfreq/60000000.gpu/* 2>/dev/null
chmod 0664 /sys/class/devfreq/60000000.gpu/vdsp_governor/* 2>/dev/null
chmod 0664 /sys/class/display/dispc0/* 2>/dev/null
chmod 0664 /sys/class/display/dphy0/* 2>/dev/null
chmod 0664 /proc/sys/net/ipv4/* 2>/dev/null

# GPU configuration
echo 812000000 > /sys/class/devfreq/60000000.gpu/min_freq
echo 936000000 > /sys/class/devfreq/60000000.gpu/max_freq
echo 936000000 > /sys/class/devfreq/60000000.gpu/target_freq
echo 50 > /sys/class/devfreq/60000000.gpu/polling_interval
echo "vdsp_dvfs" > /sys/class/devfreq/60000000.gpu/governor

# Display configuration
echo 80 > /sys/class/display/dispc0/actual_fps
echo 800000 > /sys/class/display/dphy0/freq

# VDSP configuration
echo 936000000 > /sys/class/devfreq/vdsp/min_freq
echo 936000000 > /sys/class/devfreq/vdsp/max_freq
echo 936000000 > /sys/class/devfreq/60000000.gpu/vdsp_governor/work_freq
echo 614400000 > /sys/class/devfreq/60000000.gpu/vdsp_governor/idle_freq
echo 1 > /sys/class/devfreq/60000000.gpu/vdsp_governor/dvfs_enable

echo 1 > /proc/sys/net/ipv4/tcp_low_latency
echo "4096 87380 256960" > /proc/sys/net/ipv4/tcp_rmem
echo "4096 16384 256960" > /proc/sys/net/ipv4/tcp_wmem
echo 0 > /proc/sys/net/ipv4/tcp_sack
echo 0 > /proc/sys/net/ipv4/tcp_dsack
echo 0 > /proc/sys/net/ipv4/tcp_timestamps
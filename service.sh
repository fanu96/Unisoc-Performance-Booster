#!/system/bin/sh

GAME_PKG="com.tencent.ig"
ALT_GAME_PKG="com.pubg.krmobile"

# Loop forever
while true; do
  # Check if PUBG Global or Korean version is in focus or add your game here
  IN_GAME=$(dumpsys window | grep -E "mCurrentFocus.*($GAME_PKG|$ALT_GAME_PKG)")
  [ -f /sys/class/thermal/thermal_zone0/temp ] && THERMAL=$(cat /sys/class/thermal/thermal_zone0/temp) || THERMAL=0

  if [ -n "$IN_GAME" ]; then
    # Game is in foreground
    PID=$(pgrep -f "$GAME_PKG")
    [ -n "$PID" ] && taskset -p c0 "$PID" >/dev/null

    if [ "$THERMAL" -lt 70000 ]; then
      echo 90 > /sys/class/display/dispc0/actual_fps
      echo 936000000 > /sys/class/devfreq/60000000.gpu/min_freq
      echo 50 > /sys/class/devfreq/60000000.gpu/polling_interval
      echo "performance" > /sys/bus/cpu/devices/cpu6/cpufreq/scaling_governor
      echo "performance" > /sys/bus/cpu/devices/cpu7/cpufreq/scaling_governor
      echo "vdsp_dvfs" > /sys/class/devfreq/60000000.gpu/governor
    else
      echo 90 > /sys/class/display/dispc0/actual_fps
      echo 812000000 > /sys/class/devfreq/60000000.gpu/min_freq
      echo 50 > /sys/class/devfreq/60000000.gpu/polling_interval
      echo "vdsp_dvfs" > /sys/class/devfreq/60000000.gpu/governor
    fi
  else
    # Not in game
    echo 90 > /sys/class/display/dispc0/actual_fps
    echo 812000000 > /sys/class/devfreq/60000000.gpu/min_freq
    echo 50 > /sys/class/devfreq/60000000.gpu/polling_interval
  fi

  sleep 2
done
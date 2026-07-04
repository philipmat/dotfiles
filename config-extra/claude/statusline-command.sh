#!/bin/sh
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cwd_full=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
cwd=$(echo "$cwd_full" | awk -F'/' '{if(NF>=2) print $(NF-1)"/"$NF; else print $NF}')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Format context usage
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  ctx_part="ctx:${used_int}%"
else
  ctx_part=""
fi

# Format weekly usage
if [ -n "$week" ]; then
  week_int=$(printf '%.0f' "$week")
  week_part="7d:${week_int}%"
else
  week_part=""
fi

# Assemble output
out="${model}  📁 ${cwd}"
if [ -n "$ctx_part" ] && [ -n "$week_part" ]; then
  out="$out  |  ${ctx_part}  ${week_part}"
elif [ -n "$ctx_part" ]; then
  out="$out  |  ${ctx_part}"
elif [ -n "$week_part" ]; then
  out="$out  |  ${week_part}"
fi
printf "%s" "$out"

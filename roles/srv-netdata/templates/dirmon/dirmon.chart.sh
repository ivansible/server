# shellcheck shell=bash
# no need for shebang - this file is loaded from charts.d.plugin
# SPDX-License-Identifier: GPL-3.0-or-later

# netdata
# real-time performance and health monitoring, done right!
# (C) 2016 Costa Tsaousis <costa@tsaousis.gr>

# main configuration string
dirmon_disk_dirs="{{ disk_dirs }}"

# _update_every is a special variable - it holds the number of seconds
# between the calls of the _update() function
dirmon_update_every="{{ update_every }}"

# the priority is used to sort the charts on the dashboard, 1 = the first chart
dirmon_priority="{{ chart_priority }}"

# global variables to store our collected data
# they need to start with the module name
declare -a dirmon_disk_ids
declare -A dirmon_dir_names
declare -A dirmon_dir_paths
declare -A dirmon_dir_sizes

# _check is called once, to find out if this chart should be enabled or not
dirmon_check() {
  # this should return: 0 to enable the chart, 1 to disable the chart
  local dirs desc path name did

  dirs=${dirmon_disk_dirs// /_}
  for desc in ${dirs//,/ }; do
    # shellcheck disable=SC2076
    if [[ "$desc" =~ '(' ]]; then
      name=${desc##*\(}
      name=${name%%)}
      name=${name//_/ }
      path=${desc%%\(*}
    else
      path="$desc"
      name=$(echo "$path" |
            sed 's|/usr/|/u/|g' |
            sed 's|/var/|/v/|g' |
            sed 's|/lib/|/l/|g' |
            sed 's|/home/|/h/|g' |
            sed 's|/cache/|/c/|g')
    fi
    did="did_$(echo "$path" |tr -cs '0-9a-zA-Z' _)"
    did=${did%%_}
    dirmon_disk_ids+=($did)
    dirmon_dir_names[$did]="$name"
    dirmon_dir_paths[$did]="$path"
    # echo "[$did] [$path] [$name]"
    [ -d "$path" ] && continue
    error "directory does not exist: $path"
    return 1
  done

  return 0
}

dirmon_get() {
  # collect values for each dimension
  # shellcheck disable=SC2068
  for did in ${dirmon_disk_ids[@]}; do
    dirmon_dir_sizes[$did]=$(du -msx "${dirmon_dir_paths[$did]}")
  done
  # return: 0 = send the data to netdata, 1 = failure to collect the data
  return 0
}

# _create is called once, to create the charts
dirmon_create() {
  # create the chart with 3 dimensions
  echo "CHART dirmon.dirsize '' 'Directory Size' 'MiB' '' '' line $((dirmon_priority)) $dirmon_update_every"
  # shellcheck disable=SC2068
  for did in ${dirmon_disk_ids[@]}; do
    echo "DIMENSION '$did' '${dirmon_dir_names[$did]}' absolute 1 1"
  done
  return 0
}

# _update is called continuously, to collect the values
dirmon_update() {
  # the first argument to this function is the microseconds since last update
  # pass this parameter to the BEGIN statement (see bellow).
  dirmon_get || return 1
  echo "BEGIN dirmon.dirsize $1"
  # shellcheck disable=SC2068
  for did in ${dirmon_disk_ids[@]}; do
    echo "SET $did = ${dirmon_dir_sizes[$did]}"
  done
  echo "END"
  return 0
}

# dirmon_check; dirmon_create; dirmon_update 123

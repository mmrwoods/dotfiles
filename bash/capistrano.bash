#!bash
_find_capfile()
{
    dir=$PWD
    while [[ "$dir" != "/" ]]; do
        if [ -f $dir/Capfile ]; then
            echo $dir/Capfile
            return 0
        fi
        dir=$(dirname $dir)
    done
    return 1
}

_cap_dash_t()
{
  # this is the raw call to capistrano
  if cap --version | grep "Rake" > /dev/null; then
    # capistrano 3+
    echo "$(cap -AT)"
  else
    # capistrano 2
    echo "$(cap -vT)"
  fi
}

_cap_tasks()
{
  # this returns back a list of all tasks
  echo "$(echo "$cap_dash_t"|grep -e '^cap'|awk {'print $2'}|sed 's/:/\:/g')"
}

_cap_stages()
{
  # this returns a list of all stages setup via capistrano multistage
  echo "$(echo "$cap_dash_t"|grep -e '^cap'|grep 'Set the target stage to'|awk {'print $2'}|sed 's/:/\:/g')"
}

_cap()
{
  COMPREPLY=()
  # don't consider a ":" a wordbreak - this lets us complete on "cap foo:*"
  COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # our _cap_task output is good if we're 1) in the same directory as the last
  # time we ran it or 2) we're using the same Capfile as the last time we ran
  # it. so check for those first before we re-run "cap -T" since that's pretty
  # expensive time-wise.
  new_cwd=$PWD
  if [[ "$cur_cwd" != "$new_cwd" ||  -z "$cap_tasks" ]]; then
    new_capfile=$(_find_capfile)
    if [ $? == 1 ]; then
      # no Capfile found, bail
      return 0
    fi

    if [ "$new_capfile" != "$cur_capfile" ]; then
      cur_capfile=$new_capfile
      cap_dash_t=$(_cap_dash_t)
    fi

    cap_complete=$(_cap_tasks)

    # "cap staging deploy" is legit but "cap deploy staging" isn't. to avoid
    # this we filter stages out of our completions once we've got more than
    # two words ("cap" will always be the first)

    if [[ ${#COMP_WORDS[@]} -gt 2 ]]; then
      for i in $(_cap_stages); do
        cap_complete=$(echo $cap_complete|sed "s/[[:<:]]$i[[:>:]]//g")
      done
    fi
  fi
  COMPREPLY=( $(compgen -W "${cap_complete}"  -- ${cur}))
}

complete -F _cap cap

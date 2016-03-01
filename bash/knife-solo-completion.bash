# Hacky command completion for knife solo
#
# Obliterates any existing knife completion on the assumption that if you're
# using knife solo, you're only using knife solo. Works for me, but not ideal.
#
# Only completes using node config file names, and therefore does not trigger
# ssh completions, on the assumption these files match fully qualified host
# names or a host name in your ssh config. Again, works for me, but not ideal.

_knife_solo()
{
  local cur cmd

  cur=${COMP_WORDS[COMP_CWORD]}
  cmd=${COMP_WORDS[2]}

  case ${COMP_CWORD} in
    1)
      COMPREPLY=($(compgen -W "solo" ${cur}))
      ;;
    2)
      COMPREPLY=($(compgen -W "bootstrap clean cook init prepare" ${cur}))
      ;;
    3)
      if [ "$cmd" != "init" ] && [ -d nodes ]; then
        local nodes=`ls -1 nodes/*.json | sed 's/\(nodes\/\)\(.*\)\(.json\)/\2/'`
        COMPREPLY=($(compgen -W "${nodes}" ${cur}))
      fi
      ;;
    4)
      if [ "$cmd" == "cook" ]; then
        local configs=`ls -1 nodes/*.json`
        COMPREPLY=($(compgen -W "${configs}" ${cur}))
      fi
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

complete -F _knife_solo knife

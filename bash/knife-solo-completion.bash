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
  prev=${COMP_WORDS[COMP_CWORD-1]}

  case ${prev} in
    knife)
      COMPREPLY=($(compgen -W "solo" ${cur}))
      ;;
    solo)
      if [ -f Gemfile ] && grep knife-solo_data_bag Gemfile &> /dev/null; then
        local solocmds="bootstrap clean cook data init prepare"
      else
        local solocmds="bootstrap clean cook init prepare"
      fi
      COMPREPLY=($(compgen -W "${solocmds}" ${cur}))
      ;;
    bootstrap|clean|cook|prepare)
      if [ -d nodes ]; then
        local nodes=`ls -1 nodes/*.json | xargs -n1 basename | sed 's/\(.*\)\(.json\)/\1/'`
        COMPREPLY=($(compgen -W "${nodes}" ${cur}))
      fi
      ;;
    data)
      COMPREPLY=($(compgen -W "bag" ${cur}))
      ;;
    *)
      local solocmd=${COMP_WORDS[2]}
      case ${solocmd} in
        bootstrap|cook|prepare)
          local configs=`ls -1 nodes/*.json`
          COMPREPLY=($(compgen -W "${configs}" ${cur}))
          ;;
        data)
          case ${prev} in
            bag)
              COMPREPLY=($(compgen -W "create edit list show" ${cur}))
              ;;
            edit|show)
              local databags=`ls -1 data_bags/`
              COMPREPLY=($(compgen -W "${databags}" ${cur}))
              ;;
            create|list)
              COMPREPLY=()
              ;;
            *)
              local items=`ls -1 data_bags/${prev}/*.json | xargs -n1 basename | sed 's/\(.*\)\(.json\)/\1/'`
              COMPREPLY=($(compgen -W "${items}" ${cur}))
              ;;
          esac
          ;;
        *)
          COMPREPLY=()
          ;;
      esac
      ;;
  esac
}

complete -F _knife_solo knife

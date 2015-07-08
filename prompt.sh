PSORG=$PS1;

if [ -n "${BASH_VERSION}" ]; then
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${DIR}/base.sh
export C_Black="\[\033[0;30m\]"
export C_DarkGray="\[\033[1;30m\]"
export C_Blue="\[\033[0;34m\]"
export C_LightBlue="\[\033[1;34m\]"
export C_Green="\[\033[0;32m\]"
export C_LightGreen="\[\033[1;32m\]"
export C_Cyan="\[\033[0;36m\]"
export C_LightCyan="\[\033[1;36m\]"
export C_Red="\[\033[0;31m\]"
export C_LightRed="\[\033[1;31m\]"
export C_Purple="\[\033[0;35m\]"
export C_LightPurple="\[\033[1;35m\]"
export C_Brown="\[\033[0;33m\]"
export C_Yellow="\[\033[1;33m\]"
export C_LightGray="\[\033[0;37m\]"
export C_White="\[\033[1;37m\]"
export C_Reset="\[\033[0\]"
export CE_Black="\E[0;30m"
export CE_DarkGray="\E[1;30m"
export CE_Blue="\E[0;34m"
export CE_LightBlue="\E[1;34m"
export CE_Green="\E[0;32m"
export CE_LightGreen="\E[1;32m"
export CE_Cyan="\E[0;36m"
export CE_LightCyan="\E[1;36m"
export CE_Red="\E[0;31m"
export CE_LightRed="\E[1;31m"
export CE_Purple="\E[0;35m"
export CE_LightPurple="\E[1;35m"
export CE_Brown="\E[0;33m"
export CE_Yellow="\E[1;33m"
export CE_LightGray="\E[0;37m"
export CE_White="\E[1;37m"
export CE_Reset="\E[0m"
  C_1=${C_Yellow}
  CE_1=${CE_Yellow}
  C_2=${C_Black}
  CE_2=${CE_Black}
  C_3=${C_Yellow}
  CE_3=${CE_Yellow}
  C_W=${C_White}
  CE_W=${CE_White}
# current time, HH.MM
PROMPT_TIME="\t"
# HH.MM :( user@host:pwd ):
# user@host
PROMPT_LOC=$(printf "${C_W}%s${C_1}@${C_W}%-.10s" "\u" "\h")
# pwd
PROMPT_DIR=$(printf "${C_W}%-.60s" "\w")
# HH.MM .:( user@host:pwd ):..........
PROMPT_CONTEXT=$(printf "${C_W}%s ${C_W}:${C_2}( %s${C_1}:%s ${C_2})${C_W}:" "${PROMPT_TIME}" "${PROMPT_LOC}" "${PROMPT_DIR}")
PROMPT_DATE="\d"
#"\$(getNetwork \$(tail -n 1 ~/.ifstats))\$(getBattery)\$(getCPU \$(tail -n 1 ~/.topstats))
PS1="${PROMPT_CONTEXT}\n ${C_1}\W${C_Yellow} \! > \[\033[0m\]"

    : ${omg_ungit_prompt:=$PS1}
    : ${omg_second_line:='\w • '}

    : ${omg_is_a_git_repo_symbol:=''}
    : ${omg_has_untracked_files_symbol:=''}        #                ?    
    : ${omg_has_adds_symbol:=''}
    : ${omg_has_deletions_symbol:=''}
    : ${omg_has_cached_deletions_symbol:=''}
    : ${omg_has_modifications_symbol:=''}
    : ${omg_has_cached_modifications_symbol:=''}
    : ${omg_ready_to_commit_symbol:=''}            #   →
    : ${omg_is_on_a_tag_symbol:=''}                #   
    : ${omg_needs_to_merge_symbol:='ᄉ'}
    : ${omg_detached_symbol:=''}
    : ${omg_can_fast_forward_symbol:=''}
    : ${omg_has_diverged_symbol:=''}               #   
    : ${omg_not_tracked_branch_symbol:=''}
    : ${omg_rebase_tracking_branch_symbol:=''}     #   
    : ${omg_merge_tracking_branch_symbol:=''}      #  
    : ${omg_should_push_symbol:=''}                #    
    : ${omg_has_stashes_symbol:=''}

    : ${omg_default_color_on:='\[\033[1;37m\]'}
    : ${omg_default_color_off:='\[\033[0m\]'}
    : ${omg_last_symbol_color:='\e[0;31m\e[40m'}

    PROMPT='$(build_prompt)'
    RPROMPT='%{$reset_color%}%T %{$fg_bold[white]%} %n@%m%{$reset_color%}'

    function enrich_append {
        local flag=$1
        local symbol=$2
        local color=${3:-$omg_default_color_on}
        if [[ $flag == false ]]; then symbol=' '; fi

        echo -n "${color}${symbol}  "
    }

    function custom_build_prompt {
        local enabled=${1}
        local current_commit_hash=${2}
        local is_a_git_repo=${3}
        local current_branch=$4
        local detached=${5}
        local just_init=${6}
        local has_upstream=${7}
        local has_modifications=${8}
        local has_modifications_cached=${9}
        local has_adds=${10}
        local has_deletions=${11}
        local has_deletions_cached=${12}
        local has_untracked_files=${13}
        local ready_to_commit=${14}
        local tag_at_current_commit=${15}
        local is_on_a_tag=${16}
        local has_upstream=${17}
        local commits_ahead=${18}
        local commits_behind=${19}
        local has_diverged=${20}
        local should_push=${21}
        local will_rebase=${22}
        local has_stashes=${23}

        local prompt=""
        local original_prompt=$PS1


        # foreground
        local black='\e[0;30m'
        local red='\e[1;31m'
        local green='\e[1;32m'
        local yellow='\e[1;33m'
        local blue='\e[1;34m'
        local purple='\e[1;35m'
        local cyan='\e[1;36m'
        local white='\e[0;37m'

        #background
        local background_black='\e[40m'
        local background_red='\e[41m'
        local background_green='\e[42m'
        local background_yellow='\e[43m'
        local background_blue='\e[44m'
        local background_purple='\e[45m'
        local background_cyan='\e[46m'
        local background_white='\e[47m'

        local reset='\e[0m'     # Text Reset]'

        local green_on_black="${green}${background_black}"
        local yellow_on_black="${yellow}${background_black}"
        local red_on_black="${red}${background_black}"
        local white_on_black="${white}${background_black}"


        # Flags
        local omg_default_color_on="${green_on_black}"

        if [[ $is_a_git_repo == true ]]; then
            # on filesystem
            prompt="${white_on_black} <"
#            prompt+=$(enrich_append $has_stashes $omg_has_stashes_symbol "${yellow_on_black}")

            prompt+=$(enrich_append $has_untracked_files $omg_has_untracked_files_symbol "${red_on_black}")
            prompt+=$(enrich_append $has_modifications $omg_has_modifications_symbol "${red_on_black}")
            prompt+=$(enrich_append $has_deletions $omg_has_deletions_symbol "${red_on_black}")


            # ready
            prompt+=$(enrich_append $has_adds $omg_has_adds_symbol "${green_on_black}")
            prompt+=$(enrich_append $has_modifications_cached $omg_has_cached_modifications_symbol "${green_on_black}")
            prompt+=$(enrich_append $has_deletions_cached $omg_has_cached_deletions_symbol "${green_on_black}")

            # next operation

            prompt+=$(enrich_append $ready_to_commit $omg_ready_to_commit_symbol "${green_on_black}")

            # where

            prompt="${prompt}${white_on_black}> ${red_on_black}"
            if [[ $detached == true ]]; then
                prompt+=$(enrich_append $detached $omg_detached_symbol "${white_on_black}")
                prompt+=$(enrich_append $detached "(${current_commit_hash:0:7})" "${red_on_black}")
            else
                if [[ $has_upstream == false ]]; then
                    prompt+=$(enrich_append true "-- ${omg_not_tracked_branch_symbol}  --  (${current_branch})" "${red_on_black}")
                else
                    if [[ $will_rebase == true ]]; then
                        local type_of_upstream=$omg_rebase_tracking_branch_symbol
                    else
                        local type_of_upstream=$omg_merge_tracking_branch_symbol
                    fi

                    if [[ $has_diverged == true ]]; then
                        prompt+=$(enrich_append true "-${commits_behind} ${omg_has_diverged_symbol} +${commits_ahead}" "${white_on_black}")
                    else
                        if [[ $commits_behind -gt 0 ]]; then
                            prompt+=$(enrich_append true "-${commits_behind} ${white_on_black}${omg_can_fast_forward_symbol}${red_on_black} --" "${red_on_black}")
                        fi
                        if [[ $commits_ahead -gt 0 ]]; then
                            prompt+=$(enrich_append true "-- ${white_on_black}${omg_should_push_symbol}${red_on_black}  +${commits_ahead}" "${red_on_black}")
                        fi
                        if [[ $commits_ahead == 0 && $commits_behind == 0 ]]; then
                            prompt+=$(enrich_append true " --   -- " "${red_on_black}")
                        fi

                    fi
                    prompt+=$(enrich_append true "(${current_branch} ${type_of_upstream} ${upstream//\/$current_branch/})" "${red_on_black}")
                fi
            fi
            prompt+=$(enrich_append ${is_on_a_tag} "${omg_is_on_a_tag_symbol} ${tag_at_current_commit}" "${red_on_black}")
            prompt+=""
            prompt+="$(eval_prompt_callback_if_present)"
            prompt="${PROMPT_CONTEXT}${prompt} ${reset}\n ${C_1}\W${C_Yellow} \! > \[\033[0m\]"
        else
            prompt+="$(eval_prompt_callback_if_present)"
            prompt+="${omg_ungit_prompt}"
        fi

        echo "${prompt}"
    }

    PS2="${yellow}→${reset} "

    function bash_prompt() {
        PS1="$(build_prompt)"
    }

    PROMPT_COMMAND=bash_prompt

fi

function fish_prompt
    echo -n (set_color blue --bold)
    echo -n (pwd | sed "s|^$HOME|~|")
    echo -n (set_color green --bold)
    if git rev-parse --git-dir &>/dev/null
        git diff --quiet HEAD &>/dev/null
        if test $status = 1
            echo -n (set_color yellow --bold)
            echo -n "'"
        end
    end
    echo -n " "
end

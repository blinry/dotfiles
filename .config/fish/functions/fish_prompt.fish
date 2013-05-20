function fish_prompt
    echo -n (set_color blue --bold)
    echo -n (pwd | sed "s|^$HOME|~|")
    echo -n (set_color green --bold)
    echo -n " "
    if git rev-parse --git-dir > /dev/null 2>&1
        echo -n (git rev-parse --abbrev-ref HEAD)
        git diff --quiet HEAD ^&-
        if test $status = 1
            echo -n (set_color yellow --bold)
            echo -n "'"
        end

        echo -n " "
    end
end

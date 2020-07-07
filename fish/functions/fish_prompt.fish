function fish_prompt
    
    set exit_code $status

    # Print PWD
    echo -n (set_color blue)(prompt_pwd)' '

    # Print exit code
    if [ $exit_code != "0" ]
        set_color red
        echo -n "[$exit_code] "
    end

    # Print prompt
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    set_color normal
end

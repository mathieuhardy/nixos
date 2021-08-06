function __prompt_util_isset -a var -d "Check if variable is set"
    if set --query $var
        echo true
    else
        echo false
    end
end

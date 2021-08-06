function __prompt_setconfig -a var -d "Set the default value for a global variable"
    if not set --query $var
        set --global $var $argv[2..-1]
    end
end

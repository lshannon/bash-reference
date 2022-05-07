#!/bin/bash
#https://github.com/lshannon/bash-reference


echo_function () {
   echo 'Welcome to function one!'
}

echo_function

return_exit_code () {
    return 123
}

return_exit_code
echo $?

return_string () {
    variable_defined_in_function="I was generated in a function. Nice to meet you!"
}

return_string
echo $variable_defined_in_function

stdout_return_value () {
  local variable_defined_in_function="I too was generated in a function, but I come to you from STDOUT. Nice to meet you!"
  echo "$variable_defined_in_function"
}

stdout_return_value="$(stdout_return_value)"
echo $stdout_return_value



arg_function () {
  echo "Args 1 and 2: $1 $2"
  echo "Number of args: $#"
  echo "Total Args: $*"
}

arg_function "A" "B" "C"


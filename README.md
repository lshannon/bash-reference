# Bash Reference

Bash is a great way to automate tasks and make your life easier as both a developer or an operator.

This project contains a few samples and tricks I have found useful.

## Run A Command And Test Response

Sometimes you want to run something and then test if the response contains a certain value.

Here is an example. The 'cf' command line interface is used to talk to Cloud Foundry. With this command we are calling the for events of an application. If there is no application we are detecting that and in this case stopping the program.

```shell

OUTPUT="$(cf events spring-music)"
if [[ $OUTPUT == *"App spring not found"* ]]; then
  echo "The application does not exist, terminating the program"
  exit 1;
fi

```

## Getting The Location The Script Is Running Into A Variable

Its often handy to know where in the file system a script is running. This command will do the trick.

```shell

export START_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

```


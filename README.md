# Bash Reference

Bash is a great way to automate tasks and make your life easier as both a developer or an operator.

This project contains a few samples, tricks and stuff I can never remember :-)

## Start Off With A Bang

These samples assuming the scripts are running bash. Add this to the top of the file to ensure that is the case

```shell

#!/bin/bash

```

## Run A Command And Test Response

Sometimes you want to run something and then test if the response contains a certain value.

Here is an example. The 'cf' command line interface is used to talk to Cloud Foundry. In this example we are testing the output of that command to check if an particular application is running in Cloud Foundry. We are terminating the script if the application is not here, but we also could take this opportunity to install it.

```shell

OUTPUT="$(cf events spring-music)"
if [[ $OUTPUT == *"App spring not found"* ]]; then
  echo "The application does not exist, terminating the program"
  exit 1;
fi

```

## Checking If An Agruement Is Blank And Setting A Default

In this snippet we are prompting the user for a value, and then taking action if the supplied a value.

```shell

echo 'Enter the API (default is:https://api.run.pivotal.io)'
  read API
  echo "Read In: $API"
  if [ -z "$API" ]; then
    echo "Using default API"
    API='https://api.run.pivotal.io'
  fi

```

## Getting The Location The Script Is Running Into A Variable

Its often handy to know where in the file system a script is running. This command will do the trick.

```shell

export START_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

```

## Ensuring The Right Number Of Parameters

There are times you might wish to ensure a certain number of arguements.

```shell

if [ "$#" -ne 3 ]; then
    echo "There needs to be at least 3 args"
fi

```

## If/Else Conditions

An example of IF/Then.

```shell

if [ "$greeting" == "hello" ]; then
 echo "Hi!"
else
 echo "What...no hello?"
fi

```
## Stopping A Script If There Are No Arguements Passed In

If a script needs to be have arguements passed in for it to work, you can add logic like this in the beginning of the script to stop execution if no arguements are specified.

```shell

if [ $# -eq 0 ]; then
	    echo "Usage: startSite.sh <name serviceFile>";
	    echo "Hint: servicesToManageDev.txt, servicesToManageQA.txt, servicesToManageProduction.txt";
	    echo "Program terminating ...";
	    exit 1;
	fi

```

## Give The User A Change To Cancel

```shell

echo "Are good to continue? (Type 'Y' to proceed)"
read CONFIRMATION
if [ "$CONFIRMATION" != "Y" ]; then
  echo "Terminating the program"
  exit 0;
fi

```

## Checking If A File Exists

The following checks if a file exists.

```shell

#!/bin/bash
if [ -e smoketest.txt ]
then
    echo "We have a smoketest file. Yipeee"
else
    echo "There is no smoketest file! Boooooooooo"
fi

```

## Reading The Contents Of A File

Sometimes so many arguements are passed into a script, it makes more sense to construct a properties file. In this example we have several row, with each row consisting of arguments seperated by spaces. Here is how values can be read from a file. Note: NAMES[i] contains the args in their respective positions.

Property File:

```shell

somethingcool option1 option2 option3
anothercoolthing option1 option2 option3

```

Script to read the property file above:

```shell
  
  while read line
	do	
		IFS=':' read -ra NAMES <<< "$line"
		echo "${NAMES[1]}" "${NAMES[0]}" "${NAMES[2]}"
	done < <(grep . "$START_DIRECTORY/$CONFIG_FILE")

```
## Reading User Input And Acting Upon The Values

Its handy to give a list of options, collect what the user wants and then perform a task based on their selection. The following is a script I like to use to SSH into different machines.

```shell

echo "++++++++++++++++"
echo "Which Server?"
echo "++++++++++++++++"
echo "1: QA"
echo "2: Jenkins"
echo "3: Production"
echo "4: Production Eureka"
echo "5: Data Server"
echo "6: Artifactory"
echo "---------------"
read option

if [[ ("$option" -eq "1") ]]; then
		echo "SSHing into the QA Server"
		ssh -i xxxxx.pem xxxx@xx.xx.xxx.xxx
fi

if [[ ("$option" -eq "2") ]]; then
		echo "SSHing into the Jenkins Server"
		ssh -i xxxxx.pem xxxx@xx.xx.xxx.xxx
fi

if [[ ("$option" -eq "3") ]]; then
		echo "SSHing into the Production Server"
		ssh -i xxxxx.pem xxxx@xx.xx.xxx.xxx
fi

if [[ ("$option" -eq "4") ]]; then
		echo "SSHing into the Production Eureka Server"
		ssh -i xxxxx.pem xxxx@xx.xx.xxx.xxx
fi

if [[ ("$option" -eq "5") ]]; then
		echo "SSHing into the Data Server"
		ssh -i xxxxx.pem xxxx@xx.xx.xxx.xxx
fi

if [[ ("$option" -eq "6") ]]; then
                echo "SSHing into Artifactory"
                ssh -i xxxxx.pem xxxx@xx.xx.xxx.xxx
fi

```

## Copy Files To A Remote Server

```shell

scp target/CoolBootApp-0.0.1-SNAPSHOT.jar root@xx.xxx.xxx.xx:/path-to-folder

```

## Figuring out the name of a Linux Distro

```shell

cat /etc/*-release

```

## How to check If Script Is Running As Sudo

```shell

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

```

## Check is the previous command successfully executed

```shell

  if [ $? -eq 0 ]; then
    echo 'GREAT!'
  else
    echo 'Houston we have a problem'
  fi

```

## Check if a Docker Image is running

```shell

  # there is no keycloak image - or it crashed
  if [ ! "$(docker ps -q -f name=<name>)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=<name>)" ]; then
        # cleanup
        docker rm <name>
    fi
    # get images
    sudo docker run -p <args for server>
  fi

```

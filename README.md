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

if [ "$greeting" = "hello" ]; then
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

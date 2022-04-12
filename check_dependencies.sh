#!/bin/sh -e

#################################################################
# check_dependencies.sh
#  Author: Dave Elofson
#  Created: 2022-04-06
#################################################################

# Intended use:
#
# source check_dependencies.sh
#
# Will compare the installed version numbers of ROOT, Geant4, and Python against
# the minimum required versions supplied by ReleaseBuilder in dependencies.txt.

input="./dependencies.txt"

while read -r line; do
    echo $line;
    IFS=' ' read -r -a stringarray <<<  "$line";
    PACKAGE=${stringarray[0]};
    TAG=${stringarray[1]};

    case $PACKAGE in

        ROOT)
            echo Checkin ROOT version...
            if [[ $TAG =~ [0-9].[0-9][0-9]/[0-9][0-9] ]] ;
            then
                echo version numbering in dependencies.txt is correct
                required_major="${TAG:0:1}"
                required_minor="${TAG:2:2}"
                required_patch="${TAG:5:2}"
            else
                echo version numbering in dependencies.txt is incorrect!!
            fi

            [ -z "$ROOTSYS" ] && 1>&2 echo "ERROR: '$ROOTSYS' must be defined." && exit 1
            [ ! -x "$ROOTSYS/bin/root-config" ] && 1>&2 echo "ERROR: root-config not found." && exit 1
            version=`$ROOTSYS/bin/root-config --version`

            if [[ $version =~ [0-9].[0-9][0-9]/[0-9][0-9] ]] ;
            then
                echo version numbering from root-config is correct
                installed_major="${TAG:0:1}"
                installed_minor="${TAG:2:2}"
                installed_patch="${TAG:5:2}"
                [ "$installed_major$installed_minor$installed_patch" -lt "$required_major$required_minor$required_patch" ] && 1>&2 echo "ERROR: Installed ROOT version is insuffient." && exit 1
                echo Installed ROOT version is acceptable.

            else
                echo version numbering from root-config is incorrect!!
            fi

			;;


        geant4)
            echo Checking Geant4 version...
            if [[ $TAG =~ [0-9][0-9].[0-9].[0-9] ]] ;
            then
                echo version numbering in dependencies.txt is correct
                required_major="${TAG:0:2}"
                required_minor="${TAG:3:1}"
                required_patch="${TAG:5:1}"
            else
                echo version numbering in dependencies.txt is incorrect!!
            fi

            version=`geant4-config --version`

            if [[ $version =~ [0-9][0-9].[0-9].[0-9] ]] ;
            then
                echo version numbering from geant4-config is correct
                installed_major="${TAG:0:2}"
                installed_minor="${TAG:3:1}"
                installed_patch="${TAG:5:1}"
                [ "$installed_major$installed_minor$installed_patch" -lt "$required_major$required_minor$required_patch" ] && 1>&2 echo "ERROR: Installed Geant4 version is insuffient." && exit 1
                echo Installed Geant4 version is acceptable.

            else
                echo version numbering from geant4-config is incorrect!!
            fi

            ;;


        python)
            echo Checking python version...
            if [[ $TAG =~ [0-9].[0-9].[0-9] ]] ;
            then
                echo version numbering in dependencies.txt is correct
                required_major="${TAG:0:1}"
                required_minor="${TAG:2:1}"
                required_patch="${TAG:4:1}"
            else
                echo version numbering in dependencies.txt is incorrect!!
            fi

            version=`python --version`
			IFS=' ' read -r -a array <<< "$version"
			
            if [[ ${array[1]} =~ [0-9].[0-9].[0-9] ]] ;
            then
                echo version numbering from geant4-config is correct
                installed_major="${TAG:0:1}"
                installed_minor="${TAG:2:1}"
                installed_patch="${TAG:4:1}"
                echo "$installed_major$installed_minor$installed_patch" "$required_major$required_minor$required_patch"
				[ "$installed_major$installed_minor$installed_patch" -lt "$required_major$required_minor$required_patch" ] && 1>&2 echo "ERROR: Installed python version is insuffient." && exit 1
                echo Installed python version is acceptable.

            else
                echo version numbering from python is incorrect!!
            fi

            ;;

    esac
done < "$input" 

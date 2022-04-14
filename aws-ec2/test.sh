#!/bin/ksh
set -x
function getBuildNumber()
{
            # Get the file name
            file=`echo /mnts/cm/algoweb/imcr-owasp-combined/*.tar.gz`
            if [[ -z $file ]]
            then
              echo "Could not find a starting dependency check file: dependency_check-nnn.tar.gz"
              exit 1
            fi
            # Get the build number from the file name
            local get_build_number=`echo $file | cut -f2 -d'-' | cut -f1 -d'.'`
            echo "$get_build_number"

}

build_number=$(getBuildNumber)
echo $build_number
#if  [[ -n $buildopt ]]
#then
  # set the build number
  # try to download
#else
#<--------------------
# Get the dependency build number from snapshot

getBuildNumberfromSnapshot()
{
fail1=
fail2=
url_prefix="https://artifacts-scm.dstcorp.net/artifactory/algo-local/com/ssctech/algo/imcr/application/tangerine-stable/5.2.0-SNAPSHOT"
orig_build_number=$build_number
while [ -n $build_number ]
do
   new_build_number=`expr $build_number + 1`
   echo "${new_build_number}"
   url_tangerine=${url_prefix}/tangerine-stable-5.2.0-SNAPSHOT-${new_build_number}.tar.gz
   wget -q -N $url_tangerine
   if [[ $? -ne 0 ]]
   then
     # Download failed
     if [[ -z $fail1 ]]
     then
       fail1="true"
     #  save_build_number=${new_build_number}
     elif [[ -z $fail2 ]]
     then
       fail2="true"
     else
       echo "Couldn't find 3 in a row, so assume no new ones"
       break
     fi
   else
     # Download succeeded - save build number
echo "before removing"
     rm -f tangerine-stable-5.2.0-SNAPSHOT-${new_build_number}.tar.gz
    # save_build_number==${new_build_number}
     fail1=
     fail2=
   fi
   build_number=${new_build_number}
done

# Get latest dependency-check
while [ -n $build_number ]
do
  dep_check_name=dependency_check-${build_number}.tar.gz
  url_dependency_check=${url_prefix}/${dep_check_name}
  wget -q -N $url_dependency_check
  if [[ $? -ne 0 ]]
  then
    echo "Could not download latest dependency check file: ${dep_check_name} trying for older"
  else
    break
  fi
  build_number=`expr $build_number - 1`
done
echo final_build_number=${build_number}

# Removing the old dependency_check file (make sure its not the same as the original)
if [[ $build_number != $orig_build_number ]]
then
  rm -f dependency_check-${orig_build_number}.tar.gz
fi
#<--------------------

#fi

if [[ ! -e ${dep_check_name} ]]
then
  echo "Cannot find ${dep_check_name}"
  exit 1
fi

# Extracting tar file into Download directory
download_dir=`pwd`/download
mkdir ${download_dir}
tar xzvf ${dep_check_name} -C ${download_dir}
if [[ $? -ne 0 ]]
then
  echo "Could not extract tar file ${dep_check_name}"
  exit 1
fi

export CREATE_IUS_PATH=/mnts/buildarea/package/git_repos/createius/0.dev
export UTILS_PATH=/mnts/buildarea/package/git_repos/utils/master

export CLASSPATH="${CREATE_IUS_PATH}/bin:${UTILS_PATH}/bin:${CREATE_IUS_PATH}/lib/ant.jar:${CREATE_IUS_PATH}/lib/commons-cli-1.2.jar:${CREATE_IUS_PATH}/lib/jackson-core-2.12.0.jar:${CREATE_IUS_PATH}/lib/jackson-databind-2.12.0.jar:${CREATE_IUS_PATH}/lib/jackson-annotations-2.12.0.jar"
export JDK8_PATH=/mnts/cdstools/ibm-java-sdk-8.0.5.10/centos_linux-x86_64-7.7

# Creating Dependency report
output_dir="/mnts/cm/algoweb/imcr-owasp-combined"
${JDK8_PATH}/bin/java com.ibm.createIUs.json.CreateIMCRThirdPartyReport -b ${build_number} -i ${download_dir} -o ${output_dir}
if [[ $? -ne 0 ]]
then
  echo "Could not create report"
  exit 1
fi

output_file="owasp_imcr.html"
if [[ ! -e $output_file ]]
then
  echo "Could not find output file ${output_file}"
  exit 1
fi

save_file="owasp_imcr.${build_number}.html"
save_dir="${output_dir}/save"
if [[ -d $save_dir ]]
then
  cp -p $output_dir/$output_file $save_dir/$save_file
  if [[ $? -ne 0 ]]
  then
    echo "Could not copy ouptut file ${output_dir}/${output_file} to directory ${save_dir}"
    exit 1
  fi
fi

# Removing Download directory
rm -fr ${download_dir}

}

#build_number=
while getopts "n:h" arg
do
  case $arg in
        n)
        build_number="$OPTARG"
        getBuildNumberfromSnapshot $build_number
        ;;
        h|*)
      echo "help"
      usage
      exit 0
    ;;
  esac
done

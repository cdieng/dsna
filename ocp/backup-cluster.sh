function kubectlgetall {

  mkdir -p ${2}/${1}

  for i in $(oc api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do

    echo "Resource:" $i

    oc -n ${1} get --ignore-not-found ${i} -o yaml > ${2}/${1}/${i}.yaml

    if [[ ! -s ${2}/${1}/${i}.yaml ]]; then /bin/rm -f ${2}/${1}/${i}.yaml; fi

  done

}



DIR=backup-$(date | sed -e 's/ /-/g')

mkdir -p $DIR

for i in $(oc get ns | grep -v NAME); do

  echo "Namespace:" $i

  kubectlgetall $i $DIR

done

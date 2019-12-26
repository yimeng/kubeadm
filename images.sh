#kubeadm config images list |sed -e 's/^/docker pull /g' -e 's#k8s.gcr.io#gcr.azk8s.cn/google-containers#g' |sh -x

images=`kubeadm config images list |awk -F'/' '{print $2}'`

for imageName in ${images[@]};do
    docker pull gcr.azk8s.cn/google-containers/$imageName
    docker tag  gcr.azk8s.cn/google-containers/$imageName k8s.gcr.io/$imageName
    docker rmi  gcr.azk8s.cn/google-containers/$imageName
done

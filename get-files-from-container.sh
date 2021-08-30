sudo docker create -ti --name dummy oommf-spack-which
sudo docker cp dummy:/packages-before.txt packages-before.txt
sudo docker cp dummy:/packages-after.txt packages-after.txt
sudo docker rm -f dummy

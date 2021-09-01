docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
mkdir wheels
arr=(${PLATFORM//,/ })

## now loop through the above array
for i in "${arr[@]}"
do
    Cont=$(docker run --platform $i -v "${PWD}/wheels":/opt/wheels -w /opt --rm -itd python:3.7-buster)
    docker cp ../requirements.txt $Cont:/opt
    docker exec -i $Cont \
      /bin/bash -c "export LIBSODIUM_MAKE_ARGS=-j4; \
                    pip wheel --find-links wheels -r requirements.txt -w wheels && \
                    chmod 755 wheels/*"
    docker rm -f $Cont
done

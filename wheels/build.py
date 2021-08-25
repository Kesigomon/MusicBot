import threading
import subprocess
import os
import shutil


def tasks(platform: str):
    tag = platform.replace("/", "_")
    
    subprocess.run(
        "docker buildx build "
        f"--load -t musicbot_wheels:{tag} "
        f"--platform {platform} .".split()
    )
    container_name =  f"tmp_{tag}"
    subprocess.run(
        "docker run " 
        f"--platform {platform} "
        f"--name {container_name} "
        f"--rm -itd musicbot_wheels:{tag}".split()
    )
    subprocess.run(f"docker cp {container_name}:/opt/wheels/. {os.curdir}/wheels".split())
    subprocess.run(f"docker rm -f {container_name}".split())
    

def main():
    platforms = ["linux/amd64", "linux/arm64"]
    shutil.copy("../requirements.txt", ".")
    subprocess.run("docker run --rm --privileged multiarch/qemu-user-static --reset -p yes".split())
    threads = [threading.Thread(target=tasks, args=(platform,)) for platform in platforms]
    [t.start() for t in threads]
    [t.join() for t in threads]

main()

Use [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) (Docker Image with streamed Desktop via VNC inside HTML5 Website) to basically initiate a SSH connection and run SSH with X11 fowarding, like running this on a regular Linux machine:

    ssh -Y myuser@1.2.3.4 xeyes

# Run

For e.g. use this to run VMware Workstation on the host machine and display it inside the Docker container:

    docker run -d --name vmware \
        --add-host=host.docker.internal:host-gateway \
        -p 5800:5800 \
        -p 5900:5900 \
        -e VNC_PASSWORD=hugo1234 \
        -v /your/ssh/keys:/ssh:ro \
        -e SSH_TARGET="root@host.docker.internal" \
        -e REMOTE_COMMAND="vmware" \
        -e APP_NAME="VMware Workstation" \
        dersimn/remote-x-over-ssh

You have to provide an SSH Keypair to authenticate to the remote server.

> [!CAUTION]
> Carefully consider the implications of streaming applications via SSH.
> The above example basically gives anyone who can access the VNC stream root access to the host machine (running VMWare).
> Why? A malicious entity creates a new virtual machine and adds a shared folder to that machine. Since VMWare is running as the root user, it is authorized to mount and write to the entire host file system within the VM. Since you can remotely control the VM via the VNC stream, you also have full access to the host file system. Now simply inject a malicious SSH key into /root/.ssh/authorized_keys and connect directly to the host machine.
> Attack scenarios like this also exist in other applications.

See [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) for parameters to configure the parent image.

# Build

    docker buildx create --name mybuilder
    docker buildx use mybuilder

    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t dersimn/remote-x-over-ssh \
        --push \
        .

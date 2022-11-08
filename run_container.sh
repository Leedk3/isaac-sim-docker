#!/bin/bash

name='isaac-sim'

echo "Launching docker and status ..."

if docker ps -a --format '{{.Names}}' | grep -w $name &> /dev/null; then
	if docker ps -a --format '{{.Status}}' | egrep 'Exited' &> /dev/null; then
		echo "Container is already running. Attach to ${name}"
		docker start $name 	
		docker exec -it $name bash 
	elif docker ps -a --format '{{.Status}}' | egrep 'Created' &> /dev/null; then
		echo "Container is already created. Start and attach to ${name}"
		docker start $name 	
		docker exec -it $name bash
	elif docker ps -a --format '{{.Status}}' | egrep 'Up' &> /dev/null; then
		echo "Docker is already running"
		docker exec -it $name bash
	fi 
else

	echo "Starting ..."
	echo "docker run --name ${name} isaac-sim"
    docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y" --rm --network=host \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $XAUTH:/root/.Xauthority \
    -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
    -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
    -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
    -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
    -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
    -v ~/docker/isaac-sim/config:/root/.nvidia-omniverse/config:rw \
    -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
    -v ~/docker/isaac-sim/documents:/root/Documents:rw \
    -v ~/docker/isaac-sim/documents:/root/Documents:rw \
    -v ~/docker/isaac-sim/documents:/root/Documents:rw \
    -v /home/$USER/isaacSim/OmniIsaacGymEnvs:/root/OmniIsaacGymEnvs:rw \
    -v /home/$USER/isaacSim/OmniIsaacGymEnvs/omniisaacgymenvs.egg-info:/root/OmniIsaacGymEnvs/omniisaacgymenvs.egg-info \
    -v /home/$USER/isaacSim/IsaacGymEnvs:/root/IsaacGymEnvs:rw \
    -v /home/$USER/isaacSim/IsaacGymEnvs/isaacgymenvs.egg-info:/root/IsaacGymEnvs/isaacgymenvs.egg-info \
    isaac-sim:latest
    # nvcr.io/nvidia/isaac-sim:2022.1.1

fi


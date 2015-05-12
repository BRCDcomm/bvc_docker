# bvc_docker
Brocade Vyatta Controller working in a docker container

Requirements:
* Docker https://docs.docker.com/userguide/
* Brocade Vyatta Controller zip files (bvc-1.2.0.zip and bvc-dependencies-1.2.0.zip) which can be downloaded from here: http://www.brocade.com/forms/jsp/vyatta-controller/index.jsp

Note: for OSX and Windows I recommend using boot2docker with docker https://github.com/boot2docker/boot2docker.  If using boot2docker I recommend initializing it as follows to make sure your vm has enough memory for bvc: ```boot2docker init -m 6500```

Setup:
* git clone this repository or simply just download the Dockerfile https://github.com/brcdcomm/bvc_docker/raw/master/Dockerfile
* put the Dockerfile and the 2 bvc zip files downloaded from the link above into a working directory on your system
* cd to that directory and make sure your docker environment is initialized and type: 
  ```docker build -t bvc .``` NOTE!! don't forget the ```.``` which is how you specify the directory where the Dockerfile exists.  
  This will build the image using the Dockerfile and bvc zip files in your current directory.  The first time you build this image it will take a while (minutes) depending on the speed of your internet connection.
* type: ```docker images``` to see the list of images which should include the image you just built
* to run the image in the foreground (I recommend this until you are sure it is working correctly) type: ```docker run -p 9000:9000 -p 8181:8181 -p 6633:6633 -h bvc-docker-1 -ti bvc```
* you will see output from the bvc install script and then you will see the bvc log being tailed.  If everything starts correctly you should see the following log message at the end of the startup process: ```2015-04-15 03:47:36,271 | INFO  | ssing-executor-3 | NetconfDevice                    | 270 - org.opendaylight.controller.sal-netconf-connector - 1.1.2.Helium-SR2 | RemoteDevice{controller-config}: Netconf connector initialized successfully```
* with the bvc container running in the foreground like this you can exit it by typing ctrl-c.  Note that if you exit the container using ctrl-c it will terminate the bvc process.  See below for how to run the container in the background.
* To connect to the bvc container, for example to try the UI, you will need to use the docker host address and the mapped ports.  You can see above that we mapped the ports 8181, 9000, and 6633.  To get the docker host address when using boot2docker type: ```boot2docker ip```
* Let's say your boot2docker ip is: 192.168.59.103, then you would open a browser and enter 192.168.59.103:9000 to use the UI
* If you are using boot2docker and you would like to access your bvc container outside your host then you will need to map the ports in virtual box.  To do this on OSX go to settings for the boot2docker-vm in VirtualBox.  Go to Network.  Click on the "Port Forwarding" button.  Then add the port mappings above to the boot2docker-vm.  This will allow you to access the UI by entering localhost:9000 or the IP address of your host machine in the browser or to access the UI from other machines using the IP address of your host machine or connect OF switches to your bvc container using the IP address of your host machine.
* To run your image in the background run it as follows: ```docker run -p 9000:9000 -p 8181:8181 -p 6633:6633 -h bvc-docker-1 -d bvc_image``` and then use: ```docker logs <container_name>``` to see the logs.
* To see your running container type: ```docker ps```
* To stop a container that is running in the background type: ```docker kill <container_name>``` 
* See docker documentation for all the info https://docs.docker.com/userguide/

# What is this ?
 A very lightweight docker utility written for **linux** which neatly wraps up the most useful docker commands

# Why does someone need it ?
  * Well for the beginners to docker, managaing the images and the containers can all seem bit too much, Which is what I certainly felt in my beginnings. This library **simplifies your workflow.**
  * And by default, docker leaves all the unused images and containers created **in the stale state**, just lying there. Although, techincally they don't take too much space due to caching, I don't like stale images and containers just lying around, corrupting my docker queries for images and containers
  * And, most importantly, for **the ease of use**. It does not matter, how many configuration options a service has and how customizable it is, unless it is intiutive for user(Both beginners and the experienced) to use it. It just imporved overall experience. I used to do it by creating bunch of command line aliases, which then slowly evovled into this **dockerh**

# How do I use this ?
  * You need to have docker already installed on your system, as this library makes calls to docker internally.
  * **Features**
    * **Commit** your changes. This internally creates a docker image<br/>
      ```dockerh commit``` <br/><br/>
    * **Update** your program. This internally builds a new container and stops any existing container<br/>
      ```dockerh update``` <br/><br/>
    * **Start** your program. This interanlly calls `docker start`.<br/>
      ```dockerh start``` <br/><br/>
    * **Stop** your program. This interanlly calls `docker stop`<br/>
      ```dockerh stop``` <br/><br/>
    * Check the **status** of your program. This internally calls `docker ps` with containter name as filter<br/>
      ```dockerh status``` <br/><br/>
    * See the live **logs** of your program. This internally calls `docker attach`<br/>
      ```dockerh log``` <br/><br/>
    * **Clear** all the stale images of your program. This internally calls `docker image prune`<br/>
      ```dockerh clear``` <br/><br/>
  * **Advanced Features**
    * Docker needs unique names  to identify both the containers and images. It certainly is cumbersome to provide the names each time. So **dockerh** creates a random name for your docker containers and images, and manages it completely itself, so that you don't have to provide it each time or even remember it for that matter. As you can clearly see in the above listed **dockerh** commands, none of them take name as input
    * But if for some reason, you feel the need to want to provide the name for yourself. You can either provide it in a **DockerH** file **or** set the environment variable **DOCKERH_MODULE_NAME** to the name you want. Remember as per the docker 
    naming conventions, the name needs to be lowercase
    
      1. **DockerH**
        ```
        my-foo-program
        ```

      2. Setting the environment bariable
        ```
        export DOCKERH_MODULE_NAME=my-foo-program
        ```
    * Also if you want to provide any environment vaiables to your docker program, just add them in a **docker-env** file. You don't have to provide the name anywhere, if it is present **dockerh** automatically picks it up.

      Example: **docker-env** file
      ```
        MY_VAR1=true
        MY_DB_USERNAME=foo
        MY_DB_PASSWORD=bar
      ```

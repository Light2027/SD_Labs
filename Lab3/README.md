# Links
https://docs.docker.com/samples/wordpress/
https://www.youtube.com/watch?v=Qw9zlE3t8Ko
https://docs.docker.com/compose/compose-file/compose-versioning/
https://www.youtube.com/watch?v=gAkwW2tuIqE&t=25s
https://gist.github.com/sheikhwaqas/9088872
https://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install 
https://docs.docker.com/compose/compose-file/compose-file-v3/
https://unix.stackexchange.com/questions/205180/how-to-pass-password-to-mysql-command-line
https://electrictoolbox.com/run-single-mysql-query-command-line/
https://phoenixnap.com/kb/how-to-create-new-mysql-user-account-grant-privileges
https://dev.mysql.com/doc/refman/8.0/en/replication-features-create-if-not-exists.html
https://stackoverflow.com/questions/11231937/bash-ignoring-error-for-a-particular-command/11231972
https://askubuntu.com/questions/800214/invalid-mutex-directory-in-argument-fileapache-lock-dir
https://hub.docker.com/layers/wordpress/library/wordpress/php8.0-fpm-alpine/images/sha256-08279a6cfdab603558a0b744e98f850a6bb5eb45caaf93e6d2475648c971ee1f?context=explore
https://www.cyberciti.biz/faq/linux-append-text-to-end-of-file/
https://askubuntu.com/questions/256013/apache-error-could-not-reliably-determine-the-servers-fully-qualified-domain-n
https://stackoverflow.com/questions/13702425/source-command-not-found-in-sh-shell
https://serverfault.com/questions/661909/the-right-way-to-keep-docker-container-started-when-it-used-for-periodic-tasks
https://github.com/docker-library/wordpress
https://stackoverflow.com/questions/341608/mysql-config-file-location-redhat-linux-server
https://www.tecmint.com/fix-error-1130-hy000-host-not-allowed-to-connect-mysql/
https://stackoverflow.com/questions/8348506/grant-remote-access-of-mysql-database-from-any-ip-address

# Part 1
Here I just took the official compose file from https://docs.docker.com/samples/wordpress/  
But as that did not satisfy my curiosity, I first figured out how it works by watching the videos above and comparing it to what I saw, then commented the compose file for later and finally made a Docker Image for my Hello World Node.JS server from scratch using debian:jessie, see here: https://github.com/Light2027/Node-Test

## Steps to deploy
Just run the following script in this directory.
```console
docker-compose up -d
```

# Part 2
This was frustrating. Thankfully I already got some experience with Debian from the previous part (Node-Test).

## MySQL
After setting up the compose file and adding the arguments, I started by setting up the Docker File for MySQL. The first problem I had was to find a way to say "Yes" to an installation in Debian without having direct access to the console, for this I found "-y" and "--force-yes" as the solution here https://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install (Also used it in Node-Test) 
The next problem I faced was similar, I had to somehow pass the password to after mysql-server finished installing. For this problem, I found "debconf-set-selections" to be the solution from this file https://gist.github.com/sheikhwaqas/9088872  
After that came a big one namely this: **ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)**. I got this error when I checked if mysql was installed using "mysql -v". Here I just decided to comment out the CMD command so that I can access the CLI. Here I found out that after restarting the MySQL service, it works in the CLI. In the build, however, it did not. So I just decided to do DB creation after the build is done using the CMD command. The next problem I encountered was related to the ARG command. It is better, in my opinion, than ENV, as it gets deleted after the build, however this time around, that was the problem, as I needed the root password for mysql_secure_installation. So I changed my ARGs to ENVs and continued using CMD to set up the database. After these issues, I only needed to google the proper MySQL commands needed and use the CLI to execute them before adding them to my multiline CMD. After finding out that each RUN command is isolated, my problems just started to disappear magically... After that, I only had a problem with IF NOT EXISTS not being a thing for CREATE USER, which I solved by letting it fail using this https://stackoverflow.com/questions/11231937/bash-ignoring-error-for-a-particular-command/11231972

## Apache + PHP + Wordpress
Here the first problem I encountered was PHP, it requires a version like "php7" instead of just "php" and cannot be just installed like it is done in this tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04  
Also I could only get PHP5 to work on it...
I encountered the following error **apache2AH00558: apache2: I could not reliably determine the server's fully qualified domain name, using 172.18.0.3. Set the 'ServerName' directive globally to suppress this message**. To solve this problem, I just needed to attach "ServerName localhost" to the end of the "/etc/apache2/apache2.conf" file.
I also had a problem keeping the container alive as apache is a background service. I added "&& tail -f /dev/null" to the end of my CMD.
Afterwards, I just had to follow this tutorial (https://idroot.us/install-wordpress-debian-8/) + a bit of reasoning (looking at the compose file from Teil1 and making connections) to install WordPress.

~~One more thing I could not connect to the database in WordPress. However, I could ping it, see dbPing.png, as that was not the main point of the exercise, and I have put in more work into this than I would have ever wanted to. So I just decided to leave it like this.
I removed the environment variables from WP Dockerfile as I could not get any use out of them, even after trying to imitate this https://github.com/docker-library/wordpress.~~  
  
**Nevermind**, after asking around I got some help from Konstantin, who told me what the problem is and told me to use the following command to replace what the mysql server is listening on: "sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf".
I also cached WordPress and copied a **wp-config.php** file I got from the original WordPress docker repository, so that I can make use of the same environmental variables:  https://github.com/docker-library/wordpress/blob/master/wp-config-docker.php
I only had one final problem. Namely, I configured the user's account to only have access to the database from the localhost, which I switched to a wild card ('%') later on, as the underlying Docker network should be isolated enough. After that, everything worked.

## Steps to build
You do not need to build it. It is done in the compose file.
Should however for some reason want to do that execute the following command in the directories of the docker image:
```console
docker build -t yourTag .
docker run -e ENVVAR=SomeValue -e ENVVAR2=SomeOtherValue -p <localPort>:<containerPort> yourTag
```
Or
```console
docker-compose build
docker-compose up -d
```

## Steps to deploy
**The environment variables can be set in the compose file.**
Just run the following script in this directory.
The images are automatically built or used if they were already built.
```console
docker-compose up -d
```
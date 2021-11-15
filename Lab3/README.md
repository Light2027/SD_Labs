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

# Part 1
Here I just took the official compose file from https://docs.docker.com/samples/wordpress/  
But as that did not satisfy my curiosity, I first figured out how it works by watching the videos above and comparing it to what I saw, then commented the compose file for later and finally made a Docker Image for my Hello World Node.JS server from scratch using debian:jessie, see here: https://github.com/Light2027/Node-Test

## Steps to deploy
Just run the following script in this directory.
```console
docker-compose up -d
```

# Part 2
This was tricky. Thankfully I already got some experience with debian from the previous part (Node-Test).

## MySQL
After setting up the compose file and adding the arguments to it I started by setting up the Docker File for MySQL. The first problem I had was to find a way to say "Yes" to an installation in Debian without having direct access to the console, for this I found "-y" and "--force-yes" as the solution here https://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install (Also used it in Node-Test) 
The next problem I faced was similar in nature, I had to somehow pass the password to after mysql-server finished installing, for this problem I found "debconf-set-selections" to be the solution from this file https://gist.github.com/sheikhwaqas/9088872  
After that came a big one namely this: **ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)**. I got this error when I tried to check if mysql was installed using "mysql -v". Here I just decided to comment out the CMD command so that I can access the CLI. Here I found out that after restarting the mysql service it works in the CLI. In the build, however, it did not. So I just decided to do things such as db creation after the build is done using the CMD command. The next problem I encountered was related to the ARG command, it is better in my opinion than ENV, as it gets deleted after the build, however this time around that was the problem, as I needed the root password for mysql_secure_installation. So I changed my ARGs to ENVs and continued using CMD to setup the database. After these issues I only needed to google the proper mysql commands needed and use the CLI to execute them before adding them to my multiline CMD. After finding out that each RUN command is isolated from one another my problems just started to magically disappear... After that I only had a problem with IF NOT EXISTS not being a thing for CREATE USER, which I solved by letting it fail using this https://stackoverflow.com/questions/11231937/bash-ignoring-error-for-a-particular-command/11231972

## Apache + PHP + Wordpress
Here the first problem I encountered was php, it requires a version like "php7" instead of just "php" and cannot be just installed like it is done in this tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04  
Also I could only get PHP5 to work on it...
Here I encountered the following error **apache2AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.18.0.3. Set the 'ServerName' directive globally to suppress this message**, to solve this problem I just needed to attach "ServerName localhost" to the end of the "/etc/apache2/apache2.conf" file.
I also had a problem with keeping the container alive as apache is a background service, I simply added "&& tail -f /dev/null" to the end of my CMD.
Afterward I just had to follow this tutorial (https://idroot.us/install-wordpress-debian-8/) + a bit of reasoning (looking at the compose file from Teil1 and making connections) to install wordpress.

One more thing I could not connect to the database in wordpress however I could ping it, see dbPing.png, as that was not the main point of the exercise and I have put in more work into this than I would have ever wanted to I just decided to ignore this.

## Steps to build
You don't need to build it, it is done in the compose file.
Should however for some reason want to do that execute the following command in the directories of the docker image:
```console
docker build -t yourTag .
docker run -p <localPort>:<containerPort> yourTag
```

## Steps to deploy
Just run the following script in this directory.
```console
docker-compose up -d
```
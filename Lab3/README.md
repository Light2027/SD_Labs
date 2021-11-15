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

# Part 1
Here I just took the official compose file from https://docs.docker.com/samples/wordpress/  
But as that did not satisfy my curiosity, I first figured out how it works by watching the videos above and comparing it to what I saw, then commented the compose file for later and finally made a Docker Image for my Hello World Node.JS server from scratch using debian:jessie, see here: https://github.com/Light2027/Node-Test

## Steps to deploy
Just run the following script in the directory.
```console
docker-compose up -d
```

# Part 2
This was tricky. Thankfully I already got some experience with debian from the previous part (Node-Test).

## MySQL
After setting up the compose file and adding the arguments to it I started by setting up the Docker File for MySQL. The first problem I had was to find a way to say "Yes" to an installation in Debian without having direct access to the console, for this I found "-y" and "--force-yes" as the solution here https://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install (Also used it in Node-Test) 
The next problem I faced was similar in nature, I had to somehow pass the password to after mysql-server finished installing, for this problem I found "debconf-set-selections" to be the solution from this file https://gist.github.com/sheikhwaqas/9088872  
After that came a big one namely this: **ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)**. I got this error when I tried to check if mysql was installed using "mysql -v". Here I just decided to comment out the CMD command so that I can access the CLI. Here I found out that after restarting the mysql service it works in the CLI. In the build, however, it did not. So I just decided to do things such as db creation after the build is done using the CMD command. The next problem I encountered was related to the ARG command, it is better in my opinion than ENV, as it gets deleted after the build, however this time around that was the problem, as I needed the root password for mysql_secure_installation. So I changed my ARGs to ENVs and continued using CMD to setup the database. After these issues I only needed to google the proper mysql commands needed and use the CLI to execute them before adding them to my multiline CMD. After finding out that each RUN command is isolated from one another my problems just started to magically disappear...

## Apache + PHP + Wordpress
Here the first problem I encountered was php, it requires a version like "php7" instead of just "php" and cannot be just installed like it is done in this tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04  
Also I could only get PHP5 to work on it...


## Steps to build

## Steps to deploy
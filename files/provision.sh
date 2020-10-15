#!/bin/bash
echo "Provisioning Virtual Machine"

	echo "Installing Nginx"
	apt-get update
	apt-get install nginx -y >> /dev/null
	service nginx start > /dev/null

#start service if down
	ps -ef | grep nginx |grep -v grep > /dev/null
	if [ $? != 0 ]
	then
       			/etc/init.d/nginx start > /dev/null
	fi
	
echo "Configuring Nginx to redirect to https using self signed SSL certificate"
	cp /var/www/files/site.conf /etc/nginx/conf.d/sites.conf > /dev/null
	mkdir /etc/nginx/ssl/
	chmod 700 /etc/nginx/ssl/
	cp /var/www/files/ssl.key /etc/nginx/ssl/
	cp /var/www/files/ssl.crt /etc/nginx/ssl/
	#ln -s /etc/nginx/sites-available/default /etc/nginx/sites-available/default
	rm -Rf /etc/nginx/sites-enabled/default
	#service nginx stop  1>&2 > /dev/null  
	
# Adds a crontab entry to curl google.com every minute

# Cron expression
cron="* * * * * curl http://www.google.com"

# Escape all the asterisks so we can grep for it
cron_escaped=$(echo "$cron" | sed s/\*/\\\\*/g)

# Check if cron job already in crontab
crontab -l | grep "${cron_escaped}"
if [[ $? -eq 0 ]] ;
  then
    echo "Crontab already exists. Exiting..."
    exit
  else
    # Write out current crontab into temp file
    crontab -l > mycron
    # Append new cron into cron file
    echo "$cron" >> mycron
    # Install new cron file
    crontab mycron
    # Remove temp file
    rm mycron
fi


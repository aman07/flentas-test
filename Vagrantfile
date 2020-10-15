VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "intellyzen/devops-test"
  config.vm.box_url = [
     "https://s3.ap-south-1.amazonaws.com/intellyzen-test/devops-test.box"
  ]

  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true    # Nginx HTTP
  config.vm.network :forwarded_port, guest: 443, host: 8443   # Nginx HTTPS
  config.vm.network :forwarded_port, guest: 5000, host: 5000  # Flask debug server

  config.vm.synced_folder "./","/var/www", create: true, group: "www-data", owner: "www-data"  

 # config.vm.provision "file", source: "files/site.conf", destination: "/etc/nginx/conf.d/site.conf"
  config.vm.provision "shell", path: "files/provision.sh"
  
end

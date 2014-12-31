# Preparations
system_arch = node['kernel']['machine']
case system_arch
when "x86_64"
	  system_arch = "amd64"
when "i686"
	  system_arch = "i386"
else
	  system_arch = "unsupported"
end


# postgresql 9.3 on ubuntu 12.04 installed from external repository:
apt_repository "pgdg" do
	action :add
	uri "http://apt.postgresql.org/pub/repos/apt"
	distribution "#{ node['lsb']['codename'] }-pgdg"
	components ["main"]
	arch system_arch
	key "https://www.postgresql.org/media/keys/ACCC4CF8.asc"
	trusted false
	deb_src false
end


# This installs and automatically starts bare Xorg server for ability to run google-chrome
if ! ::File.exists? ("/etc/init/xorgserver.conf")
	execute "apt_get_update" do
		user "root"
		group "root"
		command "/usr/bin/env apt-get update"
	end
	package "xserver-xorg" do
		action :install
	end
	cookbook_file "xorgserver.conf" do 
		path "/etc/init/xorgserver.conf"
		owner "root"
		group "root"
		mode "0644"
		action :create
	end
	execute "start_x_server" do
		user "root"
		group "root"
		command "/usr/bin/env service xorgserver start"
	end
end

if ! ::File.exists? ("/opt/nginx/conf/sites-available/insights.conf")
	cookbook_file "nginx.conf" do
		path "/opt/nginx/conf/nginx.conf"
		owner "nginx"
		group "nginx"
		action :create
		mode "0644"
	end
	["sites-enabled","sites-available"].each do |d|
		directory "/opt/nginx/conf/#{ d }" do
			action :create
			owner "nginx"
			group "nginx"
			mode "0755"
		end
	end
	cookbook_file "insights.conf" do
		path "/opt/nginx/conf/sites-available/insights.conf"
		owner "nginx"
		group "nginx"
		action :create
		mode "0644"
	end
	link "/opt/nginx/conf/sites-enabled/insights.conf" do
		to "/opt/nginx/conf/sites-available/insights.conf"
		link_type :symbolic
	end
	execute "restart_nginx" do
		user "root"
		group "root"
		command "/usr/bin/env service nginx restart"
	end
end


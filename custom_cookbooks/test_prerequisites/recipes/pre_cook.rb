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

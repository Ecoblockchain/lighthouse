# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

REQUIRED_PLUGINS = [
  "vagrant-berkshelf",
  "vagrant-omnibus",
  "vagrant-chef-apply",
]

REQUIRED_PLUGINS.each do |plugin|
  unless Vagrant.has_plugin? plugin
    raise "Required Vagrant plugin missing! Please run: `vagrant plugin install #{plugin}`"
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  if Vagrant.has_plugin? "vagrant-cachier"
    config.cache.scope = :box
  end

  # config.vm.provider :virtualbox do |vb|
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "apt"
    chef.add_recipe "maven"
    chef.add_recipe "java"
    chef.add_recipe "git"

    chef.json = {
      :java => {
        :jdk_version => "8",
        :install_flavor => "oracle",
        :oracle => {
          :accept_oracle_download_terms => true,
        }
      }
    }
  end

  #config.vm.provision :shell, path: "vagrant-build.sh"
  config.vm.provision :chef_apply, path: "vagrant-build-recipe.rb"

end

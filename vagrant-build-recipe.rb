git "#{Chef::Config[:file_cache_path]}/bitcoinj" do
  repository "https://github.com/bitcoinj/bitcoinj.git"
  revision "master"
  action :sync
end

git "#{Chef::Config[:file_cache_path]}/updatefx" do
  repository "https://github.com/vinumeris/updatefx.git"
  revision "master"
  action :sync
end

bash "install-bitcoinj" do
  cwd "#{Chef::Config[:file_cache_path]}/bitcoinj"
  code "mvn install -DskipTests"
end

bash "install-updatefx" do
  cwd "#{Chef::Config[:file_cache_path]}/updatefx"
  code "mvn install -DskipTests"
end

bash "package-lighthouse" do
  cwd "/vagrant"
  code "mvn package"
end

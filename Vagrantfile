Vagrant.configure('2') do |config|
  # box
  config.vm.box = 'centos/7'
  # ネットワーク
  config.vm.network :private_network, ip: '192.168.99.99'
  # プロビジョン
  config.vm.provision :bootstrap, type: 'shell', path: 'provision/bootstrap.sh'
  config.vm.provision :bootstrap_default_user, type: 'shell', path: 'provision/bootstrap_default_user.sh', privileged: false
  # 共有フォルダ
  config.vm.synced_folder '.', '/var/www/html'
  # config.vm.synced_folder '../project_name', '/home/vagrant/project_name' # 共有フォルダ設定 ホスト側ディレクトリ, ゲスト側ディレクトリ

  # キャッシュプラグイン
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box 
  end
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
PROJECT_NAME = "achmed"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("HostManager")
    # Update /etc/hosts file on the host machine
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    # Custom resolver for hostmanager so that dhcp IP addresses are used
    config.hostmanager.ip_resolver = proc do |machine|
      result = ""

      begin
        machine.communicate.execute("ifconfig eth1") do |type, data|
          result << data if type == :stdout
        end
        (ip = /^\s*inet .*?(\d+\.\d+\.\d+\.\d+)\s+/.match(result)) && ip[1]
      rescue
      end
    end
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  config.vm.define "dev", primary: true do |node|
    node.vm.box = "ubuntu/trusty32"
    node.vm.hostname = PROJECT_NAME + ".dev"
    node.vm.synced_folder ".", "/home/vagrant/" + PROJECT_NAME, type: "rsync", rsync__exclude: [
      ".git/",
      ".vagrant/",
      "var/",
      "vendor/",
      "bin/",
      "web/bundles/",
      "web/uploads/",
    ]

    node.vm.provider "virtualbox" do |vb|
      vb.name = node.vm.hostname
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    if Vagrant::Util::Platform.windows?
        node.vm.provision "shell" do |s|
          s.path = "provisioning/generic-provision.sh"
          s.privileged = false
          s.args   = [PROJECT_NAME]
      end
    else
      node.vm.provision "ansible" do |ansible|
        ansible.playbook = "provisioning/devservers.yml"
        ansible.host_key_checking = false
        ansible.groups = {
          "devservers" => ["dev"],
          "appservers" => ["app"],
          "dbservers" => ["db"],
          "searchservers" => ["search"]
        }
      end
    end

    node.vm.post_up_message = "Project URL: http://" + PROJECT_NAME + ".dev/app_dev.php"
  end

  config.vm.define "app", autostart: false do |node|
    node.vm.box = "ubuntu/trusty32"
    node.vm.hostname = "app." + PROJECT_NAME + ".dev"

    node.vm.provider "virtualbox" do |vb|
      vb.name = node.vm.hostname
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    node.vm.post_up_message = "Application URL: http://app." + PROJECT_NAME + ".dev/"
  end

  config.vm.define "db", autostart: false do |node|
    node.vm.box = "ubuntu/trusty32"
    node.vm.hostname = "db." + PROJECT_NAME + ".dev"

    node.vm.provider "virtualbox" do |vb|
      vb.name = node.vm.hostname
      vb.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

  config.vm.define "search", autostart: false do |node|
    node.vm.box = "ubuntu/trusty32"
    node.vm.hostname = "search." + PROJECT_NAME + ".dev"

    node.vm.provider "virtualbox" do |vb|
      vb.name = node.vm.hostname
      vb.customize ["modifyvm", :id, "--memory", "256"]
    end
  end
end

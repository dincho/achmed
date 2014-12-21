# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Update /etc/hosts file on the host machine
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  # Custom resolver for hostmanager so that dhcp IP addresses are used
  config.hostmanager.ip_resolver = proc do |machine|
    result = ""
    machine.communicate.execute("ifconfig eth1") do |type, data|
      result << data if type == :stdout
    end
    (ip = /^\s*inet .*?(\d+\.\d+\.\d+\.\d+)\s+/.match(result)) && ip[1]
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
    node.vm.hostname = "achmed.dev"
    node.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: [
    ]

    node.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/devservers.yml"
      ansible.host_key_checking = false
      ansible.groups = {
        "devservers" => ["dev"]
      }
    end

    node.vm.provider "virtualbox" do |vb|
      vb.name = node.vm.hostname
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    node.vm.post_up_message = "Project URL: http://achmed.dev/app_dev.php"
  end
end

$script = <<SCRIPT
sudo apt-get update
SCRIPT

Vagrant.configure("2") do |cluster|

    cluster.vm.define "docker_builder" do |machine|
        machine.vm.box = "ubuntu/trusty64"
        machine.vm.hostname = "weave-in-docker"

        machine.vm.provision "shell", inline: $script
        machine.vm.provision "docker", images: ["docker:1.11", "docker:1.11-dind"]

        machine.vm.provider "virtualbox" do |vbox|
            vbox.name = "weave in docker"
            vbox.memory = 1024
        end
    end

end

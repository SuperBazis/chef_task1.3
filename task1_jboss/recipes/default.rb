#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package %w(unzip net-tools)

remote_file '/tmp/wildfly-10.1.0.Final.zip' do
  source 'http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip'
  action :create
end

bash "Install application server" do
  code <<-SHELL
    unzip /tmp/wildfly-10.1.0.Final.zip -d /opt
    mv /opt/wildfly-10.1.0.Final /opt/wildfly
    SHELL
  not_if { ::Dir.exist?("/opt/wildfly/bin") }
end

template '/etc/systemd/system/wildfly.service' do
  source 'wildfly.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/opt/wildfly/standalone/configuration/standalone.xml' do
  source 'standalone.xml.erb'
end

service 'wildfly' do
  action [:enable, :start]
end

bash "Delay" do
  code <<-SHELL
  sleep 30
  SHELL
end
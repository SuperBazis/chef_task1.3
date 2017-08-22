remote_file '/tmp/HelloWorldWebApp.zip' do
  source 'http://centerkey.com/jboss/HelloWorldWebApp.zip'
  action :create
end

bash 'deployment' do
  code <<-SHELL
    unzip /tmp/HelloWorldWebApp.zip -d /opt/wildfly/standalone/deployments
    SHELL
  not_if { ::File.exist?('/opt/wildfly/standalone/deployments/HellowWorld') }
end

service 'wildfly' do
  action [:restart]
end

bash "Delay" do
  code <<-SHELL
  sleep 30
  SHELL
end
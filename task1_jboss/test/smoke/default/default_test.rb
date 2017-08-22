# # encoding: utf-8

# Inspec test for recipe task1_jboss::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('wildfly') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe http('http://192.168.56.100:8080/helloworld/hi.jsp') do
  its('status') { should eq 200 }
  its('body') { should match /Hello, World/ }
end

describe http('http://192.168.56.100:8080') do
  its('status') { should eq 200 }
  its('body') { should match /WildFly 10/ }
end

describe port(8080) do
  it { should be_listening }
end

describe package('java-1.8.0-openjdk') do
  it { should be_installed }
end

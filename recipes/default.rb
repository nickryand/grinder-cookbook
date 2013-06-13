#
# Cookbook Name:: grinder
# Recipe:: default.rb
#
# Copyright (C) 2013 Nick Downs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "apt"
include_recipe "java"

user "grinder" do
  comment "The Grinder System User"
  system true
  action :create
end

directory node[:grinder][:working_dir] do
  owner "grinder"
  group "grinder"
  recursive true
  action :create
end

directory node[:grinder][:jars_dir] do
  owner "grinder"
  group "grinder"
  recursive true
  action :create
end

include_recipe "grinder::jython" if node[:grinder][:jython][:upgrade]

package "unzip"

zip_path = "#{Chef::Config[:file_cache_path]}/grinder-binary.zip"

remote_file zip_path do
  source node[:grinder][:url]
  checksum node[:grinder][:checksum]
  action :create_if_missing
end

install_path = node[:grinder][:install_path]
properties_path = node[:grinder][:properties_path]

directory install_path do
  owner "grinder"
  group "grinder"
  recursive true
  action :create
end

directory properties_path do
  owner "grinder"
  group "grinder"
  recursive true
  action :create
end

template "#{properties_path}/grinder.properties" do
  source "grinder.properties.erb"
  mode 0755
  owner "grinder"
  group "grinder"
  variables(
    :properties => node[:grinder][:properties]
  )
end

# Snapshot builds have SNAPSHOT in the zip name.
bash "extract_grinder" do
  cwd install_path
  code <<-EOH
    unzip -u #{zip_path}
    chmod 755 "$(echo grinder-#{node.grinder.version}*)"
    chown -R grinder:grinder "$(echo grinder-#{node.grinder.version}*)"
  EOH
end

# This can also be a SNAPSHOT build.
ruby_block "find_grinder_path" do
  block do
    grinderfp = ::Dir.glob("#{install_path}/grinder-#{node.grinder.version}*/lib/grinder.jar").first
    node.default[:grinder][:classpath] << grinderfp unless node[:grinder][:classpath].include?(grinderfp)
  end
  notifies :create, "template[/etc/profile.d/grinder.sh]", :immediately
end

template "/etc/profile.d/grinder.sh" do
  mode 0644
  owner "root"
  group "root"
  variables(
    :properties_file => "#{properties_path}/grinder.properties"
  )
end

# Be aware, this can be the embedded ruby shipped with chef!
file "/etc/profile.d/ruby.sh" do
  mode 0644
  owner "root"
  group "root"
  content "export PATH=${PATH}:#{node['languages']['ruby']['bin_dir']}"
end

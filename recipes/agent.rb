#
# Cookbook Name:: grinder
# Recipe:: agent.rb
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
include_recipe "grinder"
include_recipe "bluepill"

working_dir = "#{node[:grinder][:working_dir]}/agent"
directory working_dir do
  owner "grinder"
  group "grinder"
  recursive true
  action :create
end

directory "/etc/bluepill" do
  owner "root"
  group "root"
  recursive true
  action :create
end

template "/etc/bluepill/grinder.agent.pill" do
  variables(
    :working_dir => working_dir,
    :properties_file => "#{node[:grinder][:properties_path]}/grinder.properties"
  )
  subscribes :create, "template[/etc/profile.d/grinder.sh]"
  notifies :reload, "bluepill_service[grinder.agent]", :delayed
end

bluepill_service "grinder.agent" do
  action [:enable, :load, :start]
end

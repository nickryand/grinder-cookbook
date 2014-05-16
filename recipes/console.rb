#
# Cookbook Name:: grinder
# Recipe:: console.rb
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
include_recipe 'grinder'
include_recipe 'build-essential'
include_recipe 'bluepill'

working_dir = "#{node[:grinder][:working_dir]}/console"
directory working_dir do
  owner node[:grinder][:user]
  group node[:grinder][:group]
  recursive true
  action :create
end

directory '/etc/bluepill' do
  owner 'root'
  group 'root'
  recursive true
  action :create
end

template "#{node[:bluepill][:conf_dir]}/grinder.console.pill" do
  variables(
    working_dir: node[:grinder][:working_dir],
    httphost: node[:grinder][:httpHost],
    httpport: node[:grinder][:httpPort],
    user: node[:grinder][:user],
    group: node[:grinder][:group]
  )
  subscribes :create, 'template[/etc/profile.d/grinder.sh]'
  notifies :reload, 'bluepill_service[grinder.console]', :delayed
end

bluepill_service 'grinder.console' do
  action [:enable, :load, :start]
end

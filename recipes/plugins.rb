#
# Cookbook Name:: grinder
# Recipe:: plugins.rb
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
include_recipe 'python'

usr = node[:grinder][:user]
grp = node[:grinder][:group]

virtualenv = "#{node[:grinder][:working_dir]}/pymodules"
directory virtualenv do
  owner usr
  group grp
  recursive true
  action :create
end

python_virtualenv virtualenv do
  owner usr
  group grp
  action :create
end

node[:grinder][:pypi][:modules].each do |pkg|
  python_pip pkg do
    virtualenv virtualenv
    action :install
  end
end

ruby_block 'add_python_modules_to_classpath' do
  block do
    module_path = []
    module_path.concat(::Dir.glob("#{virtualenv}/lib/*/site-packages"))

    module_path.each do |pymod|
      node.default[:grinder][:classpath] << pymod unless node.default[:grinder][:classpath].include?(pymod)
    end
  end
  notifies :create, 'template[/etc/profile.d/grinder.sh]', :delayed
end

#
# Cookbook Name:: grinder
# Recipe:: jython.rb
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

jython_path = "#{node[:grinder][:jars_dir]}/jython.jar"
remote_file jython_path do
  owner "root"
  group "root"
  mode 0644
  source node[:grinder][:jython][:url]
  checksum node[:grinder][:jython][:checksum]
  action :create_if_missing
end

unless node[:grinder][:classpath].include?(jython_path)
  node.default[:grinder][:classpath] << jython_path
end

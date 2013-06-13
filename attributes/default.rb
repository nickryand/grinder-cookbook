#
# Author:: Nick Downs (<nickryand@gmail.com>)
# Cookbook Name:: grinder
# Attributes:: default
#
# Copyright 2013, Nick Downs
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

default[:grinder][:version] = "3.11"
default[:grinder][:url] = "http://sourceforge.net/projects/grinder/files/The%20Grinder%203/#{node[:grinder][:version]}/grinder-#{node[:grinder][:version]}-binary.zip"
default[:grinder][:checksum] = "fa71e8e47d6ab7f3401b91f0087c20d6964e08712e303faeb1f12ea6e5d25ccd"

default[:grinder][:install_path] = "/opt"
default[:grinder][:working_dir] = "/opt/grinder"
default[:grinder][:properties_path] = "#{node[:grinder][:working_dir]}/etc/"
default[:grinder][:httpHost] = "0.0.0.0"
default[:grinder][:httpPort] = "6373"

default[:grinder][:jars_dir] = "#{node[:grinder][:working_dir]}/jars"

default[:grinder][:classpath] = ["#{node[:grinder][:jars_dir]}/*"]

# This requires a build of grinder that is built from source.
# The checking at hash 9bbd5cd8b35deb586da9697a7ce93dd5d164b5ae added support for jython2.7-b1.
default[:grinder][:jython][:upgrade] = false
default[:grinder][:jython][:url] = "http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7-b1/jython-standalone-2.7-b1.jar"
default[:grinder][:jython][:checksum] = "fef6528236c2d2f0749f4528104bbb7d8817e4b0110d1e1ae0b869cb13c711e5"

# Pypi module name for installation by the plugins recipe.
default[:grinder][:pypi][:modules] = ["requests"]

# Sane defaults
default[:grinder][:properties]["processes"] = 1
default[:grinder][:properties]["threads"] = 1
default[:grinder][:properties]["runs"] = 1
default[:grinder][:properties]["processIncrement"] = 1
default[:grinder][:properties]["processIncrementInterval"] = 60000
default[:grinder][:properties]["initialProcesses"] = 1
default[:grinder][:properties]["duration"] = 60000
default[:grinder][:properties]["script"] = ""
default[:grinder][:properties]["jvm"] = "java"
default[:grinder][:properties]["jvm.classpath"] = ""
default[:grinder][:properties]["jvm.arguments"] = ""
default[:grinder][:properties]["jvm.classpath"] = ""
default[:grinder][:properties]["jvm.arguments"] = ""
default[:grinder][:properties]["logDirectory"] = "/data"
default[:grinder][:properties]["hostID"] = node[:hostname]
default[:grinder][:properties]["consoleHost"] = "0.0.0.0"
default[:grinder][:properties]["consolePort"] = "6372"
default[:grinder][:properties]["useConsole"] = true
default[:grinder][:properties]["reportToConsole.interval"] = 500
default[:grinder][:properties]["initialSleepTime"] = 0
default[:grinder][:properties]["sleepTimeFactor"] = 1
default[:grinder][:properties]["sleepTimeVariation"] = 0.2
default[:grinder][:properties]["reportTimesToConsole"] = true
default[:grinder][:properties]["debug.singleprocess"] = false
default[:grinder][:properties]["debug.singleprocess.sharedclasses"] = ""

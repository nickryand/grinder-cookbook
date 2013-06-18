# The Grinder Cookbook

Description
===========
Installs and configures The Grinder load testing framework.

The Grinder Website: http://grinder.sourceforge.net/

Requirements
============
Chef >= 10

## Vagrant Requirements
* vagrant
* vagrant-omnibus plugin
* vagrant-berkshelf plugin

## Cookbooks
* apt
* java
* bluepill
* python

## Platform
Tested on:
* ubuntu 12.04

Attributes
==========

See `attributes/default.rb` for default values

* node[:grinder][:version] - The Grinder version to install
* node[:grinder][:url] - URL to The Grinder installation zip file
* node[:grinder][:checksum] - Zip file checksum to validate the zip file download
* node[:grinder][:install_path] - Installation base directory
* node[:grinder][:working_dir] - Working directory for Console and Agent daemons
* node[:grinder][:properties_path] - Directory path for initial grinder.properties file
* node[:grinder][:httpHost] - Listen address for the Console process
* node[:grinder][:httpPort] - Listen port for the Console process
* node[:grinder][:jars_dir] - extra jar file storage (This director is added to the java classpath)
* node[:grinder][:classpath] - Array of paths to be added to the classpath (This attribute is appended to during the chef run)
* node[:grinder][:jython][:upgrade] - Boolean to enable jython upgrade
* node[:grinder][:jython][:url] - URL to the upgraded Jython jar
* node[:grinder][:jython][:checksum] - Checksum for the upgraded Jython jar
* node[:grinder][:pypi][:modules] - Array of Pypi modules to install (See plugins.rb recipe)

The grinder.properties file has a number of tunables that are used to control
the behavior of The Grinder. There are a number of them listed inside the default
attributes file. However, the default recipe is written in such a way that simply 
adding a value to the node[:grinder][:properties] will make it into the grinder.properties
file.

If your configuration looked like this:

node[:grinder][:properties]["processes"] = 1
node[:grinder][:properties]["threads"] = 1
node[:grinder][:properties]["reportToConsole.interval"] = 500

These values would end up in the grinder.properties file like this:

```
grinder.processes = 1
grinder.threads = 1
grinder.reportToConsole.interval = 500
```

Please see `attributes/defaults.rb` for a full list of the grinder.properties default
values.

Recipes
=======

## default

## console

## agent

## jython

The Jython jar file can be upgraded. Please note that the current stable version of The Grinder does not
support the most up to date beta version of Jython. Any Jython version >= 2.7-b1 requires a grinder build
from source. The next version of The Grinder should remove this requirement.

## plugins

License and Author
==================

* Author:: Nick Downs (<nickryand@gmail.com>)

Copyright 2013 Nick Downs

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

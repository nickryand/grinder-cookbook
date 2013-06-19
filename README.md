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
* node[:grinder][:jython][:upgrade] - Boolean to enable Jython upgrade
* node[:grinder][:jython][:url] - URL to the upgraded Jython jar
* node[:grinder][:jython][:checksum] - Checksum for the upgraded Jython jar
* node[:grinder][:pypi][:modules] - Array of Pypi modules to install (See plugins.rb recipe)

The grinder.properties file has several tuneables that are used to
control the behavior of The Grinder. There are a number of them listed
inside the default attributes file. Please see `attributes/defaults.rb`
for a complete list of the tuneables.

Two of the tuneables should be pointed out. These two properties tell
the agent processes where to contact the console service. The defaults
are shown here.

```
node[:grinder][:properties]["consoleHost"] = "127.0.0.1"
node[:grinder][:properties]["consolePort"] = "6372"
```

The default recipe is written in such a way that simply adding a value
to the node[:grinder][:properties] will make it into the
grinder.properties file.

If your configuration looked like this:

```
node[:grinder][:properties]["processes"] = 1
node[:grinder][:properties]["threads"] = 1
node[:grinder][:properties]["reportToConsole.interval"] = 500
node[:grinder][:properties]["newTunable.from.newVersion"] = "New"
```

These values would end up in the grinder.properties file like this:

```
grinder.processes = 1
grinder.threads = 1
grinder.reportToConsole.interval = 500
grinder.newTunable.from.newVersion = New
```

Please see `attributes/defaults.rb` for a full list of the grinder.properties default
values.

Recipes
=======

## default
Installs and configures the grinder software. The grinder software is
downloaded and unzipped into the directory set by the
`node[:grinder][:install_path]` attribute. You can override the
grinder download location using the `node[:grinder][:url]` attribute.

The location of the grinder.jar file is discovered and set within this
recipe.

The following environment profile files are added for convenience:

* /etc/profile.d/ruby.sh:
  - Adds the default ruby bin directory to PATH.

* /etc/profile.d/grinder.sh:
  + Exports the following Shell Variables:
    - CLASSPATH: The java classpath for the grinder program
      - GRINDERPROPERTIES: The location of the default grinder.properties file
  + Defines the following aliases:
    - grconsole: Executes the Grinder console. This will require X11 Forwarding if you
                 are on a remote system. You can run the console in headless mode if you
                 pass the '-headless' command line option. By default the Grinder console
                 listens on '127.0.0.1'.
    - gragent: Runs the Grinder agent in the foreground.

## console
Run the console as a headless daemon via the bluepill process
monitoring tool.

The working directory is set to `node[:grinder][:working_dir]/console`.

## agent
Run a single agent process as a daemon via the bluepill process
monitoring tool.

The working directory is set to `node[:grinder][:working_dir]/agent`.

## jython
Upgrades the Jython jar file. The current upgrade target is Jython
version 2.7-b1.

You can override the `node[:grinder][:jython][:url]` and
`node[:grinder][:jython][:checksum]` attributes to control
which standalone Jython jar file you would like to update to.

NOTE: The current stable version of The Grinder does not work with
      the 2.7-b1 Jython version. The 3.12 version of The Grinder
      adds this support.

## plugins
Installs Pypi modules into a virtual environment at the path
`node[:grinder][:working_dir]/pymodules`.

The `node[:grinder][:pypi][:modules]` array controls which packages
are installed into the virtual environment.

The site-packages file inside the virtual environment is added
to the CLASSPATH variable.

Not all python modules work with Jython. This recipe exists as a
convenient method of getting python packages installed into a
controlled environment. I did test it with the simplejson pure
python module and it worked without issue.

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

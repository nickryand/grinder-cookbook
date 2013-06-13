name             "grinder"
maintainer       "Nick Downs"
maintainer_email "nickryand@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures The Grinder load testing framework"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

supports 'ubuntu', '= 12.04'

depends "apt"
depends "java"
depends "bluepill"
depends "python"

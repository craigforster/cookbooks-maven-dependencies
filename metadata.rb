maintainer       "Craig Forster"
maintainer_email "craig.forster@sailpoint.com"
license          "Apache 2.0"
description      "Installs/Configures maven, with extensions for getting all dependencies via a POM"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends "java"
depends "ark"
depends "maven"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end


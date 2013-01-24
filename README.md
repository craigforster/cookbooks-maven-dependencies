Description
===========

Provisions dependencies of a Maven project to a given directory.  Including this recipe
will install maven via the dependency on the `maven` cookbook.

Provides the `maven_dependencies` LWRP for pulling dependencies of a maven project,
as listed in it's POM file, from a maven repository and placing them in an arbitrary 
location.


Requirements
============

Platform:

* Debian, Ubuntu, CentOS, Red Hat, Fedora

The following Opscode cookbooks are dependencies:

* maven

Attributes
==========

None.


Usage
=====

Simply include the recipe where you want Apache Maven installed.

The `maven_dependencies` lwrp has one action:, `:install`. 


Providers/Resources
===================

maven
-----

* pom: The POM file containing the declared dependencies
* dest: the destination folder for the dependencies
* repositories: array of maven repositories to use, defaults to
 ["http://repo1.maven.apache.org/maven2"]
* owner: the owner of the resulting file, default is root


# Examples

    maven_dependencies "my-project" do
      pom "/tmp/my-project-pom.xml"
      dest "/usr/local/tomcat/lib/"
      owner "tomcat6"
    end
    # The dependencies in the POM file will be downloaded to /usr/local/tomcat/lib/


License and Author
==================

Author:: Craig Forster (<craig.forster@sailpoint.com>)

Copyright 2013 SailPoint Technologies, Inc.

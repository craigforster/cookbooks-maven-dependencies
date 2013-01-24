#
# Cookbook Name:: maven
# Provider::      default
# Author:: Bryan W. Berry <bryan.berry@gmail.com>
# Copyright 2011, Opscode Inc.
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
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

def create_dependencies_command_string(new_resource)
  dest = "-DoutputDirectory=" + new_resource.dest
  pom = "-f " + new_resource.pom
  repos = "-DremoteRepositories=" + new_resource.repositories.join(',')
  plugin_version = '2.4'
  plugin = "org.apache.maven.plugins:maven-dependency-plugin:#{plugin_version}:copy-dependencies"
  
  # The maven plugin doesn't let us set an owner while doing the copy, and doesn't cleanly
  # output the files it copied.  So, let's execute the command as the user we want to own
  # the files
  sudo = ""
  if new_resource.owner
  	sudo = "sudo -u #{new_resource.owner}"
  end
  
  %Q{#{sudo} #{node['maven']['m2_home']}/bin/mvn #{plugin} #{pom} #{dest} #{repos}}
end

def get_all_artifacts(new_resource)
    directory new_resource.dest do
      recursive true
      mode 00755
    end.run_action(:create)
    
    shell_out!(create_dependencies_command_string(new_resource))
end

action :install do
  get_all_artifacts(new_resource)
end

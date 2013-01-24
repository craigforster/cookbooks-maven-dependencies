#
# Cookbook Name:: maven_dependencies
# Resource::      default
# Author:: Craig Forster <craig.forster@sailpoint.com>
# Copyright 2013 SailPoint Technologies, Inc.
#
#

actions :install

attribute :pom, :kind_of => String, :required => true
attribute :dest, :kind_of => String, :required => true
attribute :owner, :kind_of => String
attribute :repositories, :kind_of => Array

def initialize(*args)
  super
  # we can't use the node properties when initially specifying the resource
  @artifact_id ||= @name
  @repositories ||= node['maven']['repositories']
  @action = :install
end

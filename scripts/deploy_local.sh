#!/bin/bash

gem uninstall cfn-nag -x
GEM_VERSION=0.0.01 gem build cfn-nag.gemspec
gem install cfn-nag-0.0.01.gem --no-document

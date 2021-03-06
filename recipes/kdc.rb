#
# Cookbook Name:: krb5
# Attributes:: kdc
#
# Author:: Malte Swart (<chef@malteswart.de>)
#
# Copyright 2013, Malte Swart
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

package 'krb5-kdc'

file "/etc/krb5kdc/kdc.conf" do
  owner "root"
  group "root"
  mode 0644
  content node.generate_kdc_conf
end

service "krb5-kdc" do
  action [:enable, :start]
end

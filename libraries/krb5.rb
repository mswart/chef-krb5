#
# Author:: Malte Swart (<chef@malteswart.de>)
# Cookbook Name:: krb5
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

class Chef::Node
  def generate_krb5_conf
    return nil if self['krb5'].nil?
    lines = []
    %w(libdefaults login appdefaults realms domain_realm logging capaths dbdefaults dbmodules plugins).each do |sectionname|
      next unless self['krb5'].has_key?(sectionname) and not self['krb5'][sectionname].nil?
      lines << '' if lines.length > 0
      lines << "[#{sectionname}]"
      generate_krb5_conf_section lines, self['krb5'][sectionname]
    end
    lines << ''
    lines.join "\n"
  end

  def generate_krb5_conf_section(lines, data, prefix="\t")
    data.each do |tag, value_or_values|
      next if value_or_values.nil? # skip nil values -> support deleting a presetted value
      (value_or_values.kind_of?(Array) ? value_or_values : [ value_or_values ]).each do |value|
        if value.kind_of? Hash # subsection
          lines << "#{prefix}#{tag} = {"
          generate_krb5_conf_section lines, value, prefix + "\t"
          lines << "#{prefix}}"
        else
          lines << "#{prefix}#{tag} = #{value.to_s}"
        end
      end
    end
  end
end

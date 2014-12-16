remote_file "/home/#{node['chromium']['user']}/archive.zip" do
  source node['chromium']['location']
end

execute "unzip chromium" do
  command "unzip -d ~#{node['chromium']['user']}/#{node['chromium']['expand']} ~#{node['chromium']['user']}/archive.zip && mv ~#{node['chromium']['user']}/#{node['chromium']['expand']}/*/* ~#{node['chromium']['user']}/#{node['chromium']['expand']}/"
end

execute "symlink chromium" do
  command "rm -f /usr/bin/#{node['chromium']['symlink']} && ln -s ~#{node['chromium']['user']}/#{node['chromium']['expand']}/chrome /usr/bin/#{node['chromium']['symlink']}"
end

execute "chown/chmod chrome_sandbox" do
  command "chown root:root ~#{node['chromium']['user']}/#{node['chromium']['expand']}/chrome_sandbox && chmod 4755 ~#{node['chromium']['user']}/#{node['chromium']['expand']}/chrome_sandbox"
end

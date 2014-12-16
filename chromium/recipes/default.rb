log "downloading chromium" do
    execute "download chromium" do
      command "cd ~#{node[:chromium][:user]} && wget #{node[:chromium][:location]} -O archive.zip"
    end
end

log "installing chromium" do
  execute "unzip chromium" do
    command "unzip -d ~#{node[:chromium][:user]}/#{node[:chromium][:expand]} archive.zip && mv ~#{node[:chromium][:user]}/#{node[:chromium][:expand]}/*/* ~#{node[:chromium][:user]}/#{node[:chromium][:expand]}/"
  end

  execute "symlink chromium" do
    command "ln -s ~#{node[:chromium][:user]}/#{node[:chromium][:expand]}/chrome /usr/bin/#{node[:chromium][:symlink]}"
  end

  execute "chown/chmod chrome_sandbox" do
    command "chown root:root ~#{node[:chromium][:user]}/#{node[:chromium][:expand]}/chrome_sandbox && chmod 4755 ~#{node[:chromium][:user]}/#{node[:chromium][:expand]}/chrome_sandbox"
  end
end

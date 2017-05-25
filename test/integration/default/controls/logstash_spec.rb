control 'logstash-0.1' do
  impact 1.0
  title 'ElasticSearch GPG key is imported'
  if os[:name] == 'fedora'
    describe command("rpm -q --queryformat '%{version}\n' gpg-pubkey") do
     its('stdout') { should match /d88e42b4/ }
    end
  end
end

control 'logstash-0.2' do
  impact 1.0
  title 'Logstash repository is present'
  if os[:name] == 'fedora'
    describe yum.repo('logstash-5.x') do
      it { should exist }
      it { should be_enabled }
      its('filename') { should eq '/etc/yum.repos.d/logstash.repo' }
      its('baseurl') { should match /https:\/\/artifacts.elastic.co\/packages\/5.x\/yum/ }
    end
  end
end

control 'logstash-0.3' do
  impact 1.0
  title 'Logstash requirements are installed'
  if os[:name] == 'fedora'
    %w(java-1.8.0-openjdk).each do |required|
      describe package(required) do
        it { should be_installed }
      end
    end
  end
end

control 'logstash-0.4' do
  impact 1.0
  title 'Logstash installed'
  describe package('logstash') do
    it { should be_installed }
  end
end

control 'logstash-0.5' do
  impact 1.0
  title 'Logstash service'
  describe service('logstash') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
  end
end

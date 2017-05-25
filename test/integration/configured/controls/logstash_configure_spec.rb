control 'logstash-1.1' do
  impact 1.0
  title 'Logstash configuration in place'
  %w(static regex template template_regex).each do |conf_file|
    describe file("/etc/logstash/conf.d/#{conf_file}.conf") do
      it { should be_file }
    end
  end
end

control 'logstash-1.2' do
  impact 1.0
  title 'Logstash works'
  describe file('/tmp/static.log') do
    its('content') { should match /.*echo static configuration.*/ }
  end
  describe file('/tmp/static_regex.log') do
    its('content') { should match /.*echo static regex configuration.*/ }
  end
  describe file('/tmp/template.log') do
    its('content') { should match /.*echo template configuration.*/ }
  end
  describe file('/tmp/template_regex.log') do
    its('content') { should match /.*echo template regex configuration.*/ }
  end
end


# encoding: utf-8
# copyright: 2018, The Authors

title 'sample section'

# you can also use plain tests


# you add controls here
control 'VCSA-001-01' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Check VCSA services'             # A human-readable title
  desc 'Check for the service status on the vcsa appliance'
describe vcsa() do
    it { should authenticate }
    its('ssh_status') { should cmp false }
    its('consolecli_status') { should cmp true}
    its('dcui_status') { should cmp true}
    its('shell_status') {should cmp false}
  end
end

control 'VCSA-001-02' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Health status'             # A human-readable title
  desc 'Check for the health on the vcsa appliance'
describe vcsa() do
    it { should authenticate }
    its('system_health') { should cmp 'green'}
    its('load_health') { should cmp 'green'}
    its('memory_health') { should cmp 'green'}   
    its('service_health') {should cmp 'green'}
    its('database_health') {should cmp 'green'}
    its('storage_health') { should cmp 'green'}
    its('swap_health') { should cmp 'green'}
  end
end

control 'VCSA-001-03' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Update settings'             # A human-readable title
  desc 'Check for the update settings on the vcsa appliance'
describe vcsa() do
    it { should authenticate }
    its('software_health') { should_not cmp 'red'}
    its('update_policy').auto_update { should cmp false}
    its('update_policy').auto_stage {should cmp false}
  end
end


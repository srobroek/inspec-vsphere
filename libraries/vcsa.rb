class Vcsa < Inspec.resource(1)
  name 'vcsa'
	supports platform: 'vsphere'
	desc 'Use the vsphere audit resource to get information from the vSphere API'


## Service checks

  def ssh
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessSshApi).get.value
  end


  def consolecli
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessConsolecliApi).get.value
  end

  def dcui
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessDcuiApi).get.value
  end

  def shell
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessShellApi).get.value.enabled
  end

### Health checks

  def system
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthSystemApi).get.value
  end

  def load
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthLoadApi).get.value
  end

  def memory
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthMemApi).get.value
  end

  def service
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthApplmgmtApi).get.value
  end

  def database
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthDatabasestorageApi).get.value
  end

  def storage
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthStorageApi).get.value
  end

  def swap
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthSwapApi).get.value
  end


## Software checks
  def software
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthSoftwarepackagesApi).get.value
  end

  def version
    return inspec.backend.api_client(VSphereAutomation::Appliance::SystemVersionApi).get.value.version
  end

  def build
    return inspec.backend.api_client(VSphereAutomation::Appliance::SystemVersionApi).get.value.build
  end

  def auto_update
    return inspec.backend.api_client(VSphereAutomation::Appliance::UpdatePolicyApi).get.value.auto_update
  end



  def exists?
    return true
  end
end







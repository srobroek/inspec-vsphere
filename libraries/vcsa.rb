class Vcsa < Inspec.resource(1)
  name 'vcsa'
	supports platform: 'vsphere'
	desc 'Use the vsphere audit resource to get information from the vSphere API'

  def initialize
    begin
      @auth_token = inspec.backend.authenticate
    rescue VSphereAutomation::ApiError => e
          fail Train::ClientError
    end
  end

## Service checks

  def ssh_status
    return call_api(VSphereAutomation::Appliance::AccessSshApi, "get").value
  end

  def consolecli_status
    return call_api(VSphereAutomation::Appliance::AccessConsolecliApi, "get").value
  end

  def dcui_status
    return call_api(VSphereAutomation::Appliance::AccessDcuiApi, "get").value
  end

  def shell_status
    return call_api(VSphereAutomation::Appliance::AccessShellApi, "get").value
  end

### Health checks

  def system_health
    return call_api(VSphereAutomation::Appliance::HealthSystemApi, "get").value
  end

  def load_health
    return call_api(VSphereAutomation::Appliance::HealthLoadApi, "get").value
  end

  def memory_health
    return call_api(VSphereAutomation::Appliance::HealthMemApi, "get").value
  end

  def service_health
    return call_api(VSphereAutomation::Appliance::HealthApplmgmtApi, "get").value
  end

  def database_health
    return call_api(VSphereAutomation::Appliance::HealthDatabasestorageApii, "get").value
  end

  def storage_health
    return call_api(VSphereAutomation::Appliance::HealthStorageApi, "get").value
  end

  def swap_health
    return call_api(VSphereAutomation::Appliance::HealthSwapApi, "get").value
  end


## Software checks
  def software_health
    return call_api(VSphereAutomation::Appliance::HealthSoftwarepackagesApi, "get").value
  end

  def version
    return call_api(VSphereAutomation::Appliance::SystemVersionApi, "get").version
  end

    def build
    return call_api(VSphereAutomation::Appliance::SystemVersionApi, "get").build
  end
  def authenticates?
    return true
  end



private 
  def call_api(klass,method)
    case method
      when "get"
        begin
          return klass.new(@auth_token).get.value
        rescue VSphereAutomation::ApiError => e
          fail Train::ClientError
        end
      else 
        return "not implemented yet, sorry"
    end
  end






end
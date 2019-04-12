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

  def ssh
    return call_api(VSphereAutomation::Appliance::AccessSshApi, "get")
  end

  def consolecli
    return call_api(VSphereAutomation::Appliance::AccessConsolecliApi, "get")
  end

  def dcui
    return call_api(VSphereAutomation::Appliance::AccessDcuiApi, "get")
  end

  def shell
    return call_api(VSphereAutomation::Appliance::AccessShellApi, "get").enabled
  end

### Health checks

  def system
    return call_api(VSphereAutomation::Appliance::HealthSystemApi, "get")
  end

  def load
    return call_api(VSphereAutomation::Appliance::HealthLoadApi, "get")
  end

  def memory
    return call_api(VSphereAutomation::Appliance::HealthMemApi, "get")
  end

  def service
    return call_api(VSphereAutomation::Appliance::HealthApplmgmtApi, "get")
  end

  def database
    return call_api(VSphereAutomation::Appliance::HealthDatabasestorageApi, "get")
  end

  def storage
    return call_api(VSphereAutomation::Appliance::HealthStorageApi, "get")
  end

  def swap
    return call_api(VSphereAutomation::Appliance::HealthSwapApi, "get")
  end


## Software checks
  def software
    return call_api(VSphereAutomation::Appliance::HealthSoftwarepackagesApi, "get")
  end

  def version
    return call_api(VSphereAutomation::Appliance::SystemVersionApi, "get").version
  end

  def build
    return call_api(VSphereAutomation::Appliance::SystemVersionApi, "get").build
  end

  def auto_update
    return call_api(VSphereAutomation::Appliance::UpdatePolicyApi, "get").auto_update
  end



  def exists?
    return true
  end


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






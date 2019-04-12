  class Vcsa < Inspec.resource(1)

    name 'vcsa'
    supports platform: 'vsphere'
    desc 'Use the VCSA audit resource to get information from the vSphere API'
    example <<~EXAMPLE
      describe vcsa() do
        its('ssh') { should cmp true }
      end
    EXAMPLE


    def initialize
      begin
        @auth_token = inspec.backend.authenticate
      rescue VSphereAutomation::ApiError => e
        fail Train::ClientError
      end
    end

    def ssh_status
      begin
        api_instance = VSphereAutomation::Appliance::AccessConsolecliApi.new(@auth_token)
        return api_instance.get.value
      rescue VSphereAutomation::ApiError => e
        puts "Exception when calling AccessConsolecliApi->get: #{e}"
      end
    end

        def memory_status
      begin
        api_instance = VSphereAutomation::Appliance::HealthMemApi.new(@auth_token)
        return api_instance.get.value
        
      rescue VSphereAutomation::ApiError => e
        puts "Exception when calling AccessConsolecliApi->get: #{e}"
      end
    end

    def load_status

      begin
        api_instance = VSphereAutomation::Appliance::HealthLoadApi.new(@auth_token)
        return api_instance.get.value
        
      rescue VSphereAutomation::ApiError => e
        puts "Exception when calling AccessConsolecliApi->get: #{e}"
      end
    end



  end


    






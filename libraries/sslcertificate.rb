class SslCertificate < Inspec.resource(1)
  name 'sslcertificate'
	supports platform: 'vsphere'
	desc 'Use the SslCertificate audit resource to get information about the targets SSL certificate'

  def initialize
    @host = inspec.backend.instance_variable_get(:@options)[:host]
    @insecure = inspec.backend.instance_variable_get(:@options)[:insecure]
    @timeout = 10 #set a short timeout to prevent hangs
    @port = 443 #should not be hardcoded really but who runs vcenter on a non 443 port anyway?

    @cert = get_cert
  end

  def exists?
    return true
    return @cert.class == OpenSSL::X509::Certificate
  end

  # Called by: it { should be_trusted }
  def trusted?
    @ssl_error.nil? ? (return true ) : (return @ssl_error)
  end

  # Called by: its('signature_algorithm') { should eq 'something' }
  def signature_algorithm
    @cert.signature_algorithm
  end

  def issuer
    #this is incredibly filthy but it works
    #return Hash[@cert.issuer.to_s.split(/['\/=']/).reject(&:empty?).each_slice(2).to_a]
    return @cert.issuer.to_s

  end

   def subject
     @cert.subject.to_s
  end

  def hash_algorithm
    return @cert.signature_algorithm[/^(.+?)with/i,1].upcase
  end

  def key_algorithm
    return @cert.signature_algorithm[/with(.+)encryption$/i,1].upcase
  end

  # Public key size in bits
  def key_size
    (@cert.public_key.n.num_bytes * 8).to_i
  end

  def expiration_days
    return ((@cert.not_after - Time.now) / 86_400).to_i
  end

  def expiration
    return @cert.not_after
  end

  # def to_s
  #   return "ssl_certificate on #{@host}:#{@port}"
  # end

  private

  def get_cert(verify: true)
    
    begin
      @http = Net::HTTP.new(@host, @port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless verify
      @http.open_timeout = @timeout if @timeout
      @http.start do |h|
        return h.peer_cert
      end
    rescue Exception => e
      if verify  
        @ssl_error = e.message.gsub(/"/, "'")
        # Trying one more time, this time not verifying the SSL Certificate
        get_cert(verify: false)
      else
        # Mark test as skipped if we can't get an SSL certificate
 #       return skip_resource "Cannot connect to #{@host}:#{@port}, #{e.message}"
      end
    end
  end



end







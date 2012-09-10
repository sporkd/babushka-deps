require 'json'
require 'digest/sha1'

dep 'osx defaults', :profile do
  profile.default("default")

  def config_file
    @config_file ||= "#{load_path.parent}/osx_defaults/#{profile}.json".p
  end

  def shas_dir
    "~/.babushka/shas/osx_defaults"
  end

  def sha_file
    @sha_file ||= "#{shas_dir}/#{profile}.json.sha1".p
  end

  def configs
    return @configs if @configs
    @configs = JSON.parse(IO.read(config_file))
  end

  def read_type(domain, key)
    type_map = {
      integer: 'int',
      boolean: 'bool',
      dictionary: 'dict'
    }
    if type = shell("defaults read-type #{domain} #{key}")
      type = type.split(' ').last
      type = type_map[type.to_sym] || type
    end
    type
  end

  def to_args(value)
    if value.is_a? Hash
      value.map { |k, v| "'#{k}' '#{v}'" }.join(' ')
    elsif value.is_a? Array
      "'" + value.join("' '") + "'"
    else
      value.to_s
    end
  end

  def valid?(write_type, type, value)
    return false if value.nil?
    return false if write_type && write_type != type
    if type == 'dict'
      (write_type && value.is_a?(Hash)) || value =~ /^\{.*\}$/
    elsif type == 'array'
      (write_type && value.is_a?(Array)) || value =~ /^\(.*\)$/
    else
      true
    end
  end

  met? {
    sha_file.exists? &&
    sha_file.read == Digest::SHA1.hexdigest(config_file.read)
  }
  meet {
    configs.each do |domain, defaults|
      defaults.each do |key, fields|
        descripton = fields['descripton']
        type = read_type(domain, key)
        write_type = fields['type']
        value = fields['value']
        args = to_args(value)

        if !valid?(write_type, type, value)
          log "Invalid '#{write_type}' value for '#{type}' default: #{domain} #{key}", :as => :error
          log "=> #{args}", :as => :error
        else
          if type
            log shell "defaults write #{domain} #{key} -#{type} #{args}"
          else
            log shell "defaults write #{domain} #{key} '#{value}'"
          end
        end
      end
    end
    shas_dir.p.mkdir
    sha_file.write(Digest::SHA1.hexdigest(config_file.read))
  }
end


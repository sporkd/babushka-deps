require 'json'

dep 'osx defaults', :profile do
  profile.default("default")

  def configs
    return @configs if @configs
    file = "#{load_path.parent}/osx_defaults/#{profile}.json".p
    @configs = JSON.parse(IO.read(file))
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
end


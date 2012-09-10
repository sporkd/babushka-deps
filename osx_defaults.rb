dep 'osx defaults', :profile do
  profile.default("default")

  requires 'json.gem'

  def config_file
    @config_file ||= "#{load_path.parent}/osx_defaults/#{profile}.json".p
  end

  def shas_dir
    "~/.babushka/shas/osx_defaults"
  end

  def sha_file
    @sha_file ||= "#{shas_dir}/#{profile}.json.sha1".p
  end

  def get_sha(file)
    require 'digest/sha1'
    Digest::SHA1.hexdigest(file.p.read)
  end

  def configs
    require 'rubygems'
    require 'json'
    return @configs if @configs
    @configs = JSON.parse(IO.read(config_file))
  end

  def read_type(domain, key)
    type_map = {
      :integer => 'int',
      :boolean => 'bool',
      :dictionary => 'dict'
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
    sha_file.read == get_sha(config_file)
  }

  meet {
    configs.each do |domain, defaults|
      next if domain == "restart"
      defaults.each do |key, fields|

        next if fields['disabled'] == true

        description = fields['description']
        if description.blank?
          log "No 'description' given for default: #{domain} #{key}", :as => :error
          next
        end

        write_type = fields['type']
        if write_type.blank?
          log "No 'type' given for default: #{domain} #{key}", :as => :error
          next
        end

        value = fields['value']
        if value.nil?
          log "No 'value' given for default: #{domain} #{key}", :as => :error
          next
        end

        type = read_type(domain, key)
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
    sha_file.write(get_sha(config_file))
  }

  after {
    apps = configs["restart"]
    if apps && !apps.empty?
      log shell(
        "for app in \"#{apps.join('" "')}\"; do
          killall \"$app\" > /dev/null 2>&1
        done"
      )
    end
  }
end

dep 'json.gem' do
  provides []
end

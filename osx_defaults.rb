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
    if type = shell("defaults read-type '#{domain}' '#{key}' 2>/dev/null")
      type_map = {
        :integer => 'int',
        :boolean => 'bool',
        :dictionary => 'dict'
      }
      type = type.split(' ').last
      type = type_map[type.to_sym] || type
    end
    type
  end

  def valid_type?(type)
    %w(
      array array-add dict dict-add bool int float data date string
    ).include?(type)
  end

  def valid_value?(type, value)
    case type
    when /^dict/
      value.is_a?(Hash) #|| value =~ /^\{.*\}$/
    when /^array/
      value.is_a?(Array) #|| value =~ /^\(.*\)$/
    when 'bool'
      [true, false].include?(value)
    when 'int'
      value.is_a?(Integer)
    when 'float'
      value.is_a?(Float)
    when 'data', 'date', 'string'
      value.is_a?(String)
    else
      false
    end
  end

  def to_args(value)
    if value.is_a? Hash
      value.map { |k, v| "'#{k}' '#{v}'" }.join(' ')
    elsif value.is_a? Array
      "'" + value.join("' '") + "'"
    else
      "'#{value.to_s}'"
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
        sudo = !!(fields['sudo'])

        description = fields['description']
        if description.blank?
          log "No 'description' given for default: #{domain} #{key}", :as => :error
          next
        end

        type = fields['type']
        if type.blank?
          log "No 'type' given for default: #{domain} #{key}", :as => :error
          next
        end

        value = fields['value']
        if value.nil?
          log "No 'value' given for default: #{domain} #{key}", :as => :error
          next
        end

        if !valid_type?(type)
          log "Type '#{type}' is not a valid type (#{domain} #{key})", :as => :error
          next
        end

        if !valid_value?(type, value)
          log "#{value.class} value is not compatible with '#{type}' type (#{domain} #{key})", :as => :error
          next
        end

        if current_type = read_type(domain, key)
          if type_add = /^(.+)-add/.match(type)
            if current_type != type_add[1]
              log "Cannot use '#{type}' on a '#{current_type}' type (#{domain} #{key})", :as => :error
              next
            end
          elsif type != current_type
            log "!!! #{domain} #{key} is a '#{current_type}'", :as => :warning
            unless confirm("Overwrite with '#{type}'", :default => "n")
              next
            end
          end
        end

        args = to_args(value)
        log shell "defaults write '#{domain}' '#{key}' -#{type} #{args}", :sudo => sudo
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

class RulesConfig
  def initialize(address, rule_name)
    @address = address
    @rule_name = rule_name
  end

  attr_reader :address, :rule_name

  def values
    county_specific_details || state_config_details
  end

  private

  def base_path
    "#{Rails.root}/config/rules/#{rule_name}.yml"
  end

  def county_specific_details
    all_county_details["Counties"][address[:county]] if all_county_details["Counties"].present?
  end

  def all_county_details
    @all_county_details ||= config_details[address[:state]] || {}
  end

  def config_details
    @config_details ||= YAML.load_file(base_path)
  end

  def state_config_details
    config_details[address[:state]].reject{|a| a["Counties"]} if all_county_details.present?
  end
end

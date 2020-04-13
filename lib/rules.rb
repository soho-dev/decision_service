require 'reports'
require_relative './reports/mortgage.rb'

class Rules
  attr_accessor :decision_request, :config

  def initialize(decision_request, config, reports)
    @decision_request = decision_request
    @config = config || self.config
    @reports = reports || self.reports if enabled
  end

  def enabled
    config[self.rule_name.to_sym][:enabled] rescue false
  end

  def config
    ::RulesConfig.new(decision_request.address).values
  end

  def data_present?
    @reports.present?
  end

  def reports_required
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def reports
    @reports ||= []
    reports_required.each do |report|
      @reports << "Reports::#{report}".constantize.new(decision_request).fetch
    end
  end

  def run
    @decision_request.create_decision(
      rule_name: rule_name,
      decision: decision_from_rule
    )
  end

  def decision_from_rule
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def rule_name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

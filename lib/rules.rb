require 'reports'
require_relative './reports/mortgage.rb'

class Rules

  def initialize(decision_request, config = nil, reports = nil)
    @decision_request = decision_request
    @config = config || self.config
    @reports = reports || (self.fetch_reports if enabled?) || []
  end

  def run
    return unless enabled?

    @decision_request.decisions.create(
      rule_name: rule_name,
      decision: decision_from_rule,
      message: message
    )
  end

  protected

  attr_reader :decision_request, :config, :reports

  def enabled?
    config["enabled"] rescue false
  end

  def config
    ::RulesConfig.new(decision_request.address, rule_name).values
  end

  def data_present?
    @reports.any? rescue false
  end

  def reports_required
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def decision_from_rule
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def rule_name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def message
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def fetch_reports
    @reports ||= []
    reports_required.each do |report|
      @reports << "Reports::#{report}".constantize.new(decision_request).fetch
    end
    @reports
  end
end

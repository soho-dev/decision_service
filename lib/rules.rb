class Rules
  def initialize(decision_request, config, reports)
    @decision_request = decision_request
    @config = config || self.config
    @reports = reports || self.reports if enabled
  end

  def enabled
    # config[self.rule_name.to_sym][enabled] rescue false
  end

  def config
    ::RulesConfig.new(decision_request.address).values
  end

  def data_present?
  end

  def reports_required
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def reports
    reports_required.each do |report|
      @reports << report.constantize.new(decision_request).fetch
    end
  end

  def process
    # use report class to make decision
    decision_from_rule
  end

  def decision_from_rule
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

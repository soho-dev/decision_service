class Processor
  RULE_SET= %w(mortgage_rule credit_rule)
  attr_accessor :decision_request

  def process
    RULE_SET.each do |rule|
      init_rule(rule).run
    end
    persist_decision ? decision_request : decision_error
  end

  private

  def initialize(decision_request)
    @decision_request = decision_request
  end

  def init_rule(rule_name)
    rule_class(rule_name).new(decision_request)
  end

  def rule_class(rule_name)
    "Rules::#{rule_name.camelize}".constantize
  end

  def persist_decision
    decision_request.save
  end

  def decision_error
    { message: "unable to process decision" }
  end
end

class Processer
  # credit_rule
  RULE_SET= %w(mortgage_rule)
  attr_accessor :decision_request

  def process
    RULE_SET.each do |rule|
      init_rule(rule).run
    end
    persist_decision(final_decision)
    decision_request
  end

  private

  def initialize(decision_request)
    @decision_request = decision_request
  end

  def init_rule(rule_name)
    rule_class(rule_name).new(@decision_request)
  end

  def rule_class(rule_name)
    "Rules::#{rule_name.camelize(uppercase_first_letter = true)}".constantize
  end

  def final_decision
    return "decline" if decision_request.relaod.decisions.any? do |decision|
      decision.decision == "decline"
    end
    "eligible"
  end

  def persist_decision(final_decision)
    decision_request.decision = final_decision
    decision_request.save
  end
end

class Processer
  RULE_SET= %w(credit_rule mortagage_rule)

  def process
    # run rules and store result in database
    @rules_response = {}
    RuleSet.each do |rule|
      @rules_response << init_rule(rule).run
    end
    final_decision = final_decision(rules_response)
    persist_decision(final_decision)
  end

  private

  def initialize(decision_request)
    @decision_request = decision_request
  end

  def init_rule(rule)
    #call rule class with decision_request
  end

  def final_decision(rule_response)
    # produce a cumulative output i.e. approved or decline
  end

  def persist_decision(final_decision)
    # update the final_decision in decision table and return decision
  end
end

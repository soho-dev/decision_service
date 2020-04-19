class Rules::CreditRule < Rules
  private

  def decision_from_rule
    return "unavailable" unless data_present?
    return "decline" if credit_score_is_below_threshold?
    "eligible"
  end

  def reports_required
    ["Credit"]
  end

  def rule_name
    "credit_rule"
  end

  def message
    "The credit score of applicant is checked"
  end

  def credit_score_is_below_threshold?
    @reports[0].credit_score <= credit_score_threshold
  end

  def credit_score_threshold
    config[__method__.to_s]
  end
end

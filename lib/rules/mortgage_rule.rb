require 'rules'
class Rules::MortgageRule < Rules
  def decision_from_rule
    return "unavailable" unless data_present?
    return "decline" unless mortagage_is_below_threshold?
    "eligible"
  end

  def reports_required
    ["mortagage"]
  end

  private

  def mortagage_is_below_threshold?
    @report.current_mortgage <= applicant_salary*mortagage_threshold
  end

  def applicant_salary
    @decision_request.applicant.try(:salary, 0)
  end

  def mortagage_threshold
    config[__method__]
  end
end

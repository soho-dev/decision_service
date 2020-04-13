require 'rules'
require 'reports'
require_relative '../reports/mortgage.rb'

class Rules::MortgageRule < Rules
  def decision_from_rule
    return "unavailable" unless data_present?
    return "decline" unless mortgage_is_below_threshold?
    "eligible"
  end

  def reports_required
    ["Mortgage"]
  end

  protected

  def rule_name
    "mortgage_rule"
  end

  private

  def mortgage_is_below_threshold?
    @report.current_mortgage <= applicant_salary*mortgage_threshold
  end

  def applicant_salary
    @decision_request.applicant.try(:salary, 0)
  end

  def mortgage_threshold
    config[__method__]
  end
end

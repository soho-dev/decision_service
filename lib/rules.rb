# base class for Rule
# comman logic to get config
# process method that will run to get the result
# prepare reports required to check all the reports are present
class Rules
  def initialize(decision_request)
    @decision_request = decision_request
  end

  def reports_required
    #
  end

  def process
    # use report class to make decision
  end
end

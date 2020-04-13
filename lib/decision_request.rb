class DecisionRequest
  def address
    @address
  end

  def applicant
    @applicant
  end

  def decision
    @decision
  end

  def valid?
    @valid
  end

  private

  def initialize(params)
    @params = params
    @valid = true
    create_decision_request
  end

  def create_decision_request
    begin
      @address # creates address entry
      @applicant # creates applicant entry
      @decision # creates a decision entry in an atomic manner
      # returns false if the entry fails
      # the validations logic resides in the model
    rescue
      @valid = false
    end
  end
end

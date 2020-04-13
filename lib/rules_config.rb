class RulesConfig
  def initialize(address)
    @addres = address
  end

  def values
    {
      credit_rule: {
        enabled: true,
        credit_score_threshold: 4
      },
      mortgage_rule: {
        enabled: true,
        mortgage_threshold: 5
      }
    }
  end
end

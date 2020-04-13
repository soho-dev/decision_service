def RulesConfig
  def initialize(address)
    @addres = address
  end

  def values
    {
      credit_rule: {
        enabled: true,
        credit_score_threshold: 4
      },
      mortagage_rule: {
        enabled: true,
        mortagage_percentage_threshold: 50%
      }
    }
  end
end

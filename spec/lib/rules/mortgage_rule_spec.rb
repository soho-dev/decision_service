require 'rails_helper'
require_relative '../../../lib/rules/mortgage_rule.rb'
require 'rules_config'
require 'decision_request'


RSpec.describe Rules::MortgageRule do
  subject {
    described_class.new(decision_request, nil, nil)
  }

  let(:decision_request) {
    instance_double(DecisionRequest)
  }

  describe "#enabled" do
    context "when the rule is enabled from config" do
      let(:rule_config) {
        {
          credit_rule: {
            enabled: true,
            credit_score_threshold: 4
          },
          mortagage_rule: {
            enabled: true,
            mortagage_threshold: 5
          }
        }
      }
      it "returns true" do
        allow_any_instance_of(RulesConfig).to receive(:values).and_return(rule_config)
        allow_any_instance_of(DecisionRequest).to receive(:address).and_return("address")
        expect(subject.enabled).to eq(true)
      end
    end
  end
end

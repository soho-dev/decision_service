require 'rails_helper'
require_relative '../../../lib/rules/mortgage_rule.rb'
require 'rules_config'
require 'decision_request'


RSpec.describe Rules::MortgageRule do
  subject {
    described_class.new(decision_request, nil, nil)
  }

  let(:decision_request) {
    instance_double(DecisionRequest, address: "address")
  }

  describe "#enabled" do
    context "when the rule is enabled from config" do
      let(:rule_config) {
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
      }

      it "returns true" do
        allow_any_instance_of(RulesConfig).to receive(:values).and_return(rule_config)
        # allow_any_instance_of(Reports::Mortgage).to receive(:fetch).and_return("report")
        expect(subject.enabled).to eq(true)
        expect(subject.data_present?).to eq(true)
        # expect(subject.decision_from_rule).to eq("eligible")
      end
    end
  end
end

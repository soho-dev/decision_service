require 'rails_helper'
require_relative '../../../lib/rules/mortgage_rule.rb'
require 'rules_config'
require 'decision_request'


RSpec.describe Rules::MortgageRule do
  subject {
    described_class.new(decision_request)
  }

  let(:decision_request) {
    create(:decision_request)
  }

  describe "#enabled" do
    context "when the rule is enabled from config" do
      let(:rule_config) {
        {
          "enabled" =>  true,
          "mortgage_threshold" => 10
        }
      }

      let(:failing_mortgage_report) {
        create(:mortgage_report, :failing_report, address: decision_request.address)
      }

      let(:passing_mortgage_report) {
        create(:mortgage_report, address: decision_request.address)
      }

      before(:each) {
        create(:address, decision_request: decision_request)
        create(:applicant, decision_request: decision_request)
      }

      it "returns eligible" do
        allow_any_instance_of(::RulesConfig).to receive(:values).and_return(rule_config)
        allow_any_instance_of(Reports::Mortgage).to receive(:fetch).and_return(passing_mortgage_report)
        expect(subject.send(:enabled?)).to eq(true)
        expect(subject.send(:data_present?)).to eq(true)
        expect(subject.send(:decision_from_rule)).to eq("eligible")
      end

      it "returns data not present" do
        allow_any_instance_of(::RulesConfig).to receive(:values).and_return(rule_config)
        allow_any_instance_of(Reports::Mortgage).to receive(:fetch).and_return(nil)
        expect(subject.send(:enabled?)).to eq(true)
        expect(subject.send(:data_present?)).to eq(false)
        expect(subject.send(:decision_from_rule)).to eq("unavailable")
      end

      it "returns decision of decline when report has pending mortgage" do
        allow_any_instance_of(::RulesConfig).to receive(:values).and_return(rule_config)
        allow_any_instance_of(Reports::Mortgage).to receive(:fetch).and_return(failing_mortgage_report)
        expect(subject.send(:enabled?)).to eq(true)
        expect(subject.send(:data_present?)).to eq(true)
        expect(subject.send(:decision_from_rule)).to eq("decline")
      end
    end
  end
end

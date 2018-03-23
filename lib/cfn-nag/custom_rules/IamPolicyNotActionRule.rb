require 'cfn-nag/violation'
require_relative 'base'

class IamPolicyNotActionRule < BaseRule
  def rule_text
    'IAM policy should not allow Allow+NotAction'
  end

  def rule_type
    Violation::WARNING
  end

  def rule_id
    'W16'
  end

  def audit_impl(cfn_model)
    violating_policies = cfn_model.resources_by_type('AWS::IAM::Policy').select do |policy|
      !policy.policy_document.allows_not_action.empty?
    end

    violating_policies.map(&:logical_resource_id)
  end
end

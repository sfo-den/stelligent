require 'spec_helper'
require 'password_rule_spec_helper'
require 'cfn-model'
require 'cfn-nag/custom_rules/AmazonMQBrokerUserPasswordRule'

describe AmazonMQBrokerUserPasswordRule do
  context 'AmazonMQBroker resource with Users password in plain text' do
    it 'Returns the logical resource ID of the offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_plain_text.yaml'
      )

      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker AmazonMQBroker2]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker resource with parameter password with NoEcho but default value' do
    it 'Returns the logical resource ID of the offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_parameter_noecho_with_default.yaml'
      )

      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker AmazonMQBroker2]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker resource with parameter password with default value' do
    it 'Returns the logical resource ID of the offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_parameter_default.yaml'
      )

      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker AmazonMQBroker2]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker resource with parameter password with NoEcho' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_parameter_noecho.yaml'
      )

      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker has password from Secrets Manager' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_secrets_manager.yaml'
      )
      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker has password from Secure String in Systems Manager' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_ssm_secure.yaml'
      )
      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker has password from Not Secure String in Systems Manager' do
    it 'returns offending logical resource id for offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_ssm_not_secure.yaml'
      )
      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker AmazonMQBroker2]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker has Users property defined' do
    it 'returns offending logical resource id for offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_property_not_defined.yaml'
      )
      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker has Users property with Password value nil' do
    it 'returns offending logical resource id for offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_value_nil.yaml'
      )
      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'AmazonMQBroker has Users property with no Password key' do
    it 'returns offending logical resource id for offending AmazonMQBroker resource' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/amazon_mq/amazon_mq_broker_user_password_key_not_defined.yaml'
      )
      actual_logical_resource_ids =
        AmazonMQBrokerUserPasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[AmazonMQBroker]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end
end

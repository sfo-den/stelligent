require 'spec_helper'
require 'password_rule_spec_helper'
require 'cfn-model'
require 'cfn-nag/custom_rules/IamUserLoginProfilePasswordRule'

describe IamUserLoginProfilePasswordRule do
  context 'IAM User resource LoginProfile property with parameter password with NoEcho but default value' do
    it 'Returns the logical resource ID of the offending IAMUser' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_parameter_noecho_with_default.yaml'
      )

      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[MyIamUser]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM User resource LoginProfile property with parameter password with default value' do
    it 'Returns the logical resource ID of the offending IAMUser' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_parameter_default.yaml'
      )

      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[MyIamUser]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM User resource LoginProfile property with parameter password with NoEcho' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_parameter_noecho.yaml'
      )

      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM User resource LoginProfile property has a password in plain text' do
    it 'Returns the logical resource ID of the offending IAMUser' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_plaintext.yaml'
      )

      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[MyIamUser]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM user resource LoginProfile property has password from Secrets Manager' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_secrets_manager.yaml'
      )
      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM user resource LoginProfile property has password from Secure String in Systems Manager' do
    it 'returns empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_ssm_secure.yaml'
      )
      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM user resource LoginProfile property has password from Not Secure String in Systems Manager' do
    it 'returns offending logical resource id for offending IAMUser' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_ssm_not_secure.yaml'
      )
      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[MyIamUser]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM user resource LoginProfile property is not defined' do
    it 'empty list' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_property_not_defined.yaml'
      )
      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM user resource LoginProfile property has password value as nil' do
    it 'returns offending logical resource id for offending IAMUser' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_key_nil.yaml'
      )
      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[MyIamUser]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end

  context 'IAM user resource LoginProfile property has password key not defined.' do
    it 'returns offending logical resource id for offending IAMUser' do
      cfn_model = CfnParser.new.parse read_test_template(
        'yaml/iam_user/iam_user_login_profile_password_key_not_defined.yaml'
      )
      actual_logical_resource_ids =
        IamUserLoginProfilePasswordRule.new.audit_impl cfn_model
      expected_logical_resource_ids = %w[MyIamUser]

      expect(actual_logical_resource_ids).to eq expected_logical_resource_ids
    end
  end
end

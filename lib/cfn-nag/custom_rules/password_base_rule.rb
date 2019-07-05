# frozen_string_literal: true

require 'cfn-nag/violation'
require 'cfn-nag/util/enforce_reference_parameter'
require 'cfn-nag/util/enforce_string_or_dynamic_reference'
require_relative 'base'

class PasswordBaseRule < BaseRule
  def resource_type
    raise 'must implement in subclass'
  end

  def password_property
    raise 'must implement in subclass'
  end

  def sub_property_name; end

  def audit_impl(cfn_model)
    resources = cfn_model.resources_by_type(resource_type)

    violating_resources = resources.select do |resource|
      if verify_parameter_exists(resource, password_property, sub_property_name)
        false
      else
        verify_insecure_string_and_parameter(
          cfn_model, resource, password_property, sub_property_name
        )
      end
    end

    violating_resources.map(&:logical_resource_id)
  end
end

private

def verify_parameter_exists(resource, password_property, sub_property_name)
  if sub_property_name.nil?
    resource.send(password_property).nil?
  else
    resource.send(password_property)[sub_property_name].nil?
  end
end

def verify_insecure_string_and_parameter(
  cfn_model, resource, password_property, sub_property_name
)
  if sub_property_name.nil?
    insecure_parameter?(cfn_model, resource.send(password_property)) ||
      insecure_string_or_dynamic_reference?(
        cfn_model, resource.send(password_property)
      )
  else
    insecure_parameter?(
      cfn_model, resource.send(password_property)[sub_property_name]
    ) ||
      insecure_string_or_dynamic_reference?(
        cfn_model, resource.send(password_property)[sub_property_name]
      )
  end
end

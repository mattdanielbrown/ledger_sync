# frozen_string_literal: true

require 'spec_helper'

support 'netsuite/shared_examples'

RSpec.describe LedgerSync::Ledgers::NetSuite::Customer::Operations::Create do
  it_behaves_like 'a netsuite operation'
  # include InputHelpers
  # include NetSuiteHelpers

  # let(:resource) do
  #   LedgerSync::Ledgers::NetSuite::Customer.new(
  #     customer_resource.except(:name).merge(
  #       companyName: 'Company Name',
  #       firstName: 'Test',
  #       lastName: 'This',
  #       subsidiary: LedgerSync::Ledgers::NetSuite::Subsidiary.new
  #     )
  #   )
  # end
  # let(:client) { netsuite_client }

  # it_behaves_like 'an operation'
  # it_behaves_like 'a successful operation',
  #                 stubs: %i[
  #                   stub_customer_find
  #                   stub_customer_create
  #                 ]
end

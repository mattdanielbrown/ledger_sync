# frozen_string_literal: true

module LedgerSync
  class LedgerConfigurationStore
    include Enumerable

    attr_reader :configs, :inflections, :base_module_to_config_mapping

    def initialize
      @keys = []
      @base_module_to_config_mapping = {}
      @configs = {}
      @inflections = []
      @class_configs = {}
    end

    def add_alias(client_key, existing_config)
      if respond_to?(client_key)
        raise "Alias already taken: #{client_key}" if send(client_key) != existing_config

        return
      end

      _instance_methods_for(client_key: client_key, ledger_config: existing_config)
    end

    def config_from_class(client_class:)
      @class_configs.fetch(client_class)
    end

    def config_from_base_module(base_module:)
      @base_module_to_config_mapping.fetch(base_module, nil)
    end

    def each(&)
      configs.each(&)
    end

    def find(&)
      configs.values.find(&)
    end

    def register_ledger(ledger_config:)
      @base_module_to_config_mapping[ledger_config.base_module] = ledger_config

      _instance_methods_for(
        client_key: ledger_config.root_key,
        ledger_config: ledger_config
      )
    end

    private

    def _instance_methods_for(client_key:, ledger_config:)
      @keys << client_key.to_sym

      @configs[client_key] = ledger_config
      @class_configs[ledger_config.client_class] = ledger_config

      instance_variable_set(
        "@#{client_key}",
        ledger_config
      )

      @inflections |= ledger_config.base_module.name.split('::')
      self.class.class_eval { attr_reader client_key }
    end
  end
end

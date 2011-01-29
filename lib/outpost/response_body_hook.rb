module Outpost
  module ResponseBodyHook
    RESPONSE_BODY_MAPPING = {
      :match => "=~",
      :not_match => "!~",
      :equals => "==",
      :differs => "!="
    }.freeze

    def self.extended(base)
      base.register_hook :response_body, base.method(:evaluate_response_body)
    end

    def evaluate_response_body(scout, rules)
      rules.all? do |rule,comparison|
        scout.response_body.send(RESPONSE_BODY_MAPPING[rule], comparison)
      end
    end
  end
end

# frozen_string_literal: true

RSpec::Matchers.define :match_schema do |schema|
  match do |response|
    schema_dir = "#{Dir.pwd}/spec/schemas"
    schema_path = "#{schema_dir}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end

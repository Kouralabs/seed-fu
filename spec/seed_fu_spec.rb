require 'spec_helper'

describe SeedFu do
  it 'should allow passing options with a block' do
    SeedFu.with_options(quiet: true, validate_models: true) do
      expect(SeedFu.quiet).to eq(true)
      expect(SeedFu.validate_models).to eq(true)
    end
  end

  it 'should reset back to original option values' do
    SeedFu.quiet = true
    SeedFu.validate_models = true

    SeedFu.with_options(quiet: false, validate_models: false) do
    end

    expect(SeedFu.quiet).to eq(true)
    expect(SeedFu.validate_models).to eq(true)
  end
end

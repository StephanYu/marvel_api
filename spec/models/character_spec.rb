require 'rails_helper'

describe Character do
  it { should have_and_belong_to_many(:comics) }
end

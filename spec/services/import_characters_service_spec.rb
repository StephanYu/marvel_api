require "rails_helper"

describe ImportCharactersService do 
  describe "#import" do 
    it "should import comic characters" do 
      ImportCharactersService.new.import
    end
  end
end


require 'spec_helper'

describe ParesPdf do
  describe "get cover" do
    it "get cover success" do
      pares = ParesPdf.new(get_file_url("backbone.pdf"))
      pares.get_cover.should_not be_nil
    end
  end
end
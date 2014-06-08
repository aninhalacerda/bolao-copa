require 'spec_helper'

describe "Util" do

  it "should parse all params" do
    params =  {"name" => "user", "Brasil1" => "2", "Croacia1" => "1"}
    parsed = Util.extract_games_from_params(params)

	expect(parsed).to eq({"1"=>{"Brasil"=>"2", "Croacia"=>"1"}})
  end

end
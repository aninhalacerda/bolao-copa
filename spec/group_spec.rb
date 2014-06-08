require 'spec_helper'

describe "Group" do

  it "should add new user with tips" do
    params =  {"name" => "user", "Brasil1" => "2", "Croacia1" => "1"}
    Group.add_user_tips(params)

    # assert that a new user was created with name = "user"
    # assert that the games were created with the tip id
  end

end
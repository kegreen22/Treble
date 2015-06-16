require 'rails_helper'

 
describe User do
# test no username
it "is invalid without a username" do
  john_doe = User.new(username: nil, password: 'imminent', )
  john_doe.valid?
  expect(john_doe.errors[:username]).to include("can't be blank")
end

 
# test no password
it "is invalid without a password" do
  john_doe = User.new(username: 'JohnD', password: nil)
  john_doe.valid?
  expect(john_doe.errors[:password]).to include("can't be blank")
end
 
# test valid with all user fields completed
it "is valid with all fields completed" do
  s_richards = User.new(
    username: 'SRichards',
    password: 'invisible',
    interest1: 'cloud computing',
    zipcode: '10007',
    city: 'new york',
    state: 'new york',
    free_time: 'dancing')
  expect(s_richards).to be_valid
end

# test password length failure
it "is invalid with a password shorter than 5 characters" do
  john_doe = User.new(username: 'JohnD', password: 'tom', interest1: 'retail management', zipcode: '10007', city: 'New York', state: 'New York', free_time: 'dancing')
  john_doe.valid?
  expect(john_doe.errors[:password]).to include("is too short (minimum is 5 characters)")
end

# test zipcode length failure
it "is invalid with a zipcode shorter than 5 characters" do
  jane_doe = User.new(username: 'JaneD', password: 'fantastic', interest1: 'chemical engineering', zipcode: '1004', city: 'New York', state: 'New York', free_time: 'dancing')
  jane_doe.valid?
  expect(jane_doe.errors[:zipcode]).to include("is too short (minimum is 5 characters)")
end


# test username uniqueness
  it "is invalid with a duplicate username" do
     janet = User.create(
       username: 'JaneT',
       password: 'dragon',
       interest1: 'cloud computing',
       zipcode: '10007',
       city: 'new york',
       state: 'new york',
       free_time: 'dancing'
       )
       janet2 = User.new(
         username: 'JaneT',
         password: 'dragon2',
         interest1: 'cloud computing',
         zipcode: '10007',
         city: 'new york',
         state: 'new york',
         free_time: 'dancing'
       )
       janet2.valid?
       expect(janet2.errors[:username]).to include("has already been taken")
  end
 
 
# test no interest
it "is invalid without an interest" do
  john_doe = User.new(username: 'JohnD', password: 'warmsun', interest1: nil, zipcode: '60602', city: 'Chicago', state: 'Illinois', free_time: 'rock climbing')
  john_doe.valid?
  expect(john_doe.errors[:interest1]).to include("can't be blank")
end




end # end of initial describe statement
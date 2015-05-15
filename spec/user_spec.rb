require 'rails_helper'

 
describe User do
# test no username
it "is invalid without a username" do
  john_doe = User.new(username: nil, password: 'imminent')
  john_doe.valid?
  expect(john_doe.errors[:username]).to include("can't be blank")
end

 
# test no password
it "is invalid without a password" do
  john_doe = User.new(username: 'JohnD', password: nil)
  john_doe.valid?
  expect(john_doe.errors[:password]).to include("can't be blank")
end
 
# test valid with username, password, interest1, interest2
it "is valid with a username, password and interests" do
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
 
 
# test password length failure
it "is invalid with a password shorter than 5 characters" do
  john_doe = User.new(username: 'JohnD', password: 'tom', interest1: 'retail management', zipcode: '10007', free_time: 'dancing')
  john_doe.valid?
  expect(john_doe.errors[:password]).to include("is too short (minimum is 5 characters)")
end




end # end of initial describe statement
require 'rails_helper'
 
# test no username
it "is invalid without a username" do
  john_doe = User.new(username: nil, password: 'imminent')
  john_doe.valid?
  expect(john_doe.errors[:username]).to include("Username can't be blank")
end
 
# test no password
it "is invalid without a password" do
  john_doe = User.new(username: 'JohnD', password: nil)
  john_doe.valid?
  expect(john_doe.errors[:password]).to include("Password can't be blank")
end
 
# test valid with username, password, interest1, interest2
describe New_user do
  it "is valid with a username, password and interests" do
  s_richards = User.new(
    username: 'SRichards',
    password: 'invisible',
    interest1: 'cloud computing',
    interest2: 'amazon')
  expect(s_richards).to be_valid
end
end
 
# test username uniqueness
  it "is invalid with a duplicate username" do
     janet = User.create(
       username: 'JaneT',
       password: 'dragon'
       )
       janet2 = User.new(
         username: 'JaneT',
         password: 'dragon2'
       )
       janet.valid?
       expect(janet.errors[:username]).to include("Username has already been taken")
  end
 
 
# test password length failure
it "is invalid with a password shorter than 5 characters" do
  john_doe = User.new(username: 'JohnD', password: 'tom', interest1: 'shadow', interest2: 'cat')
  john_doe.valid?
  expect(john_doe.errors[:password]).to include("Password is too short (minimum is 5 characters)")
end
 
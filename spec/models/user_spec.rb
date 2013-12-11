require 'spec_helper'

describe User do
  def create_user(attributes={})
    User.create!({
      :name => 'Joe',
      :email => 'joe@example.com',
      :password => 'passw0rd',
      :password_confirmation => 'passw0rd'
    }.merge(attributes))
  end

  it 'requires a name' do
    expect_error_from { create_user(:name => nil) }
  end

  it 'requires an e-mail address' do
    expect_error_from { create_user(:email => nil) }
  end

  it 'requires password and password confirmation to match' do
    expect_error_from { create_user(:password_confirmation => 'foo') }
  end

  it 'strips whitespace from name and e-mail' do
    sam = create_user(:name => ' Sam ', :email => ' sam@example.com ')
    sam.name.should == 'Sam'
    sam.email.should == 'sam@example.com'
  end

  it 'does NOT strip whitespace from password' do
    dan = create_user(:password => ' horsey ', :password_confirmation => ' horsey ')
    dan.authenticate('horsey').should == false
    dan.authenticate(' horsey ').should == dan
  end
end

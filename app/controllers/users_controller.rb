class UsersController < ApplicationController
  skip_before_action  :verify_authenticity_token
  before_action :require_login

  def dashboard
    @owner_contracts = UserContract.owner_contracts(current_user)
    @contracts = UserContract.users_contracts(current_user)
    @viewer_contracts = UserContract.viewer_contracts(current_user)
  end

  def add_users
    contract = Contract.find(params[:contract_id])
    new_users_array = remove_blanks(seperate_users(params))
    new_users_array.each do |user|
     emailer = Postmark::ApiClient.new(ENV["POSTMARK"])
     emailer.deliver_with_template(
      {:from=>"contact@plasticity-dev.com",
       :to=>user[0],
       :template_id=>1472662,
       :template_model=>
        {"invite_sender_name"=>current_user.users_name,
         "contract_title"=>contract.title,
         "user_position"=>readable_position(user[1]),
         "action_url"=> get_url(user,contract) }}
      )
     flash[:notice] = "Invite(s) successfully sent"
    end
   redirect_to contract.path
  end

  private
  def get_url(user, contract)
    return "#{request.protocol}#{request.host_with_port}/contracts/#{contract.id}/#{get_user_link(user[1], contract)}"
  end

  def get_user_link(position, contract)
    case position
    when 'collab'
      return contract.link
    when 'owner'
      return contract.owner_link
    when 'viewer'
      return contract.viewer_link
    else
      return 'Something went wrong with your link.'
    end
  end

  def readable_position(position)
    position == 'collab' ? "Collaborator" : position.capitalize
  end

  def remove_blanks(users)
    real_users = []
    users.each do |user|
      if user[0] != ""
        real_users.push(user)
      end
    end
    return real_users
  end

  def seperate_users(params)
     new_params = delete_obsolete(params)
     return new_params.values.each_slice(2).to_a
  end

  def delete_obsolete(params)
    [:contract_id, :submit, :action, :controller].each { |key| params.delete(key) }
    return params
  end

end

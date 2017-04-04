class UsersController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def dashboard
    if !current_user
      render "users/sessions/new"
    else
      @owner_contracts = UserContract.owner_contracts(current_user)
      @contracts = UserContract.users_contracts(current_user)
      @viewer_contracts = UserContract.viewer_contracts(current_user)
    end
  end

  def add_users
    # still need to add postmark to site.
    contract = Contract.find(params[:contract_id])
    new_users_array = seperate_users(params)
    new_users_array.each do |user|
      if user[0] != ""
       emailer = Postmark::ApiClient.new(ENV["POSTMARK"])
       emailer.deliver_with_template(
        {:from=>"contact@plasticity-dev.com",
         :to=>user[0],
         :template_id=>1472662,
         :template_model=>
          {"invite_sender_name"=>current_user.users_name,
           "contract_title"=>contract.title,
           "user_position"=>readable_position(user[1]).capitalize,
           "action_url"=>"#{request.protocol}#{request.host_with_port}/contracts/#{contract.id}/#{get_user_link(user, contract)}"}}
        )
       flash[:notice] = "Message successfully sent"
     else
       flash[:notice] = "Message did not send"
     end
   end
   redirect_to "/"
   #  return status
  end

  private

  def delete_obsolete(params)
    params.delete(:contract_id)
    params.delete(:submit)
    params.delete(:action)
    params.delete(:controller)
    return params
  end

  def get_user_link(user_array, contract)
    position = user_array[1]
    if position == "collab"
      return contract.link
    elsif position == "owner"
      return contract.owner_link
    elsif position == "viewer"
      return contract.viewer_link
    else
      return "this didn't work out"
    end
  end

  def readable_position(position)
    if position == "collab"
      return "collaborator"
    else
      return position
    end
  end

  def seperate_users(params)
     new_params = delete_obsolete(params)
     return new_params.values.each_slice(2).to_a
  end

end

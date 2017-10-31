###
# Controller: UserHelper
#
# @author Carl Anderson
###
module UserHelper

  ###
  # Method: get_users
  #
  # Description: Get the system users, except the current user
  #
  # @author Carl Anderson
  ###
  def self.get_users(current_user:)
    users = User.where('id <> ? AND record_state=0',current_user.id)
    result = []

    users.each do |user|
      result.push(UserHelper.get_user_obj(user:user))
    end

    return result
  end

  ###
  # Method: get_user_obj
  #
  # Description: Get the user object
  #
  # @author Carl Anderson
  ###
  def self.get_user_obj(user:)
    obj = {
        id:user.id,
        name:user.name,
        email:user.email
    }

    return obj
  end

end
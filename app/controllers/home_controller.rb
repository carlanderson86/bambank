###
# Controller: HomeController
#
# @author Carl Anderson
###
class HomeController < ApplicationController

  ###
  # Method: index
  #
  # Description: Get the index, render method
  #
  # @author Carl Anderson
  ###
  def index

    @current_user = current_user
    @transfers = TransferHelper.transfers_for_user(user:current_user)
    @users = UserHelper.get_users(current_user:current_user)

  end

  ###
  # Method: user_information
  #
  # Description: Get the user information, renders the partial home/user_info
  #
  # @author Carl Anderson
  ###
  def user_information
    @current_user = current_user

    render :partial => 'home/user_info'
  end

  ###
  # Method: transactions
  #
  # Description: Get the transactions, renders the partial home/transfers
  #
  # @author Carl Anderson
  ###
  def transfers
    @transfers = TransferHelper.transfers_for_user(user:current_user)

    render :partial => 'home/transfers'
  end

end
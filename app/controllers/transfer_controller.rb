###
# Controller TransfersController
#
# @author Carl Anderson
###
class TransferController < ApplicationController

  ###
  # Method: list
  #
  # Description: Get the transactions for a user
  #
  # @author Carl Anderson
  ###
  def list
    valid = true
    message = ''
    data = nil

    begin
      data = TransferHelper.transfers_for_user(user:current_user)
    rescue Exception => e
      valid = false
      message = e.message
    end

    response_obj = {
        valid:valid,
        message:message,
        data:data
    }

    render json: response_obj.to_json
  end

  ###
  # Method: create
  #
  # Description: Create the transaction
  #
  # @author Carl Anderson
  ###
  def create
    valid = true
    message = ''
    data = nil

    begin
      to_user_id = params[:to_user_id]

      if to_user_id.blank?
        raise 'A user must be specified to send the Bambeuros to'
      end

      value = params[:value]

      if value.blank?
        raise 'A value must be given for the transfer'
      end

      value = value.to_f

      if value <= 0.0
        raise 'You cannot transfer nothing'
      end

      data = TransferHelper.create(user:current_user, to_user_id:to_user_id, value:value)
    rescue Exception => e
      valid = false
      message = e.message
    end

    response_obj = {
        valid:valid,
        message:message,
        data:data
    }

    render json: response_obj.to_json
  end

end
###
# Controller: TransferHelper
#
# @author Carl Anderson
###
module TransferHelper

  ###
  # Method: transfers_for_user
  #
  # Description: Retrieve the transfers for a user
  #
  # @author Carl Anderson
  ###
  def self.transfers_for_user(user:)

    transfers = Transfer.select('t.*,uf.email AS from_email,uf.name AS from_name,ut.email AS to_email,ut.name AS to_name,p.label AS promotion_label')
                       .from('transfers t')
                       .joins('LEFT JOIN users uf ON uf.id=t.from_user_id')
                       .joins('INNER JOIN users ut ON ut.id=t.to_user_id')
                       .joins('LEFT JOIN promotions p ON p.id=t.promotion_id')
                       .where('t.from_user_id=? OR t.to_user_id=?',user.id, user.id)

    result = []
    transfers.each do |transfer|
      result.push(TransferHelper.transfer_obj(user:user, transfer:transfer))
    end

    return result
  end

  ###
  # Method: transfer
  #
  # Description: Transfer from one user to another, checks available balance and user existence
  #
  # @author Carl Anderson
  ###
  def self.create(user:, to_user_id:, value:)

    balance = user.balance

    # Allow less than or equal
    if value > balance
      raise 'Insufficient funds'
    end

    # Make sure user exists and is active
    to_user = User.where('id=? AND record_state=0',to_user_id).take

    if to_user.blank?
      raise 'Invalid recipient'
    end

    transfer = nil

    begin
      transfer_datetime = DateTime.now


      transfer = Transfer.new
      transfer.to_user_id = to_user.id
      transfer.from_user_id = user.id
      transfer.value = value
      transfer.save
      transfer_datetime = transfer.created_at

      # transfer save can rollback due to the belongs_to restrictions, checks the id to be sure
      if transfer.id.present?
        user.with_lock do
          user.balance -= value
          user.balance_updated_at = transfer_datetime
          user.save
        end

        to_user.with_lock do
          to_user.balance += value
          to_user.balance_updated_at = transfer_datetime
          to_user.save
        end
      end

    rescue Exception => e
      raise 'Failed to create transfer'
    end

    return transfer
  end

  ###
  # Method: transfer_obj
  #
  # Description: Get the transfer object, adds helpful variables to the object
  #
  # @author Carl Anderson
  ###
  def self.transfer_obj(user:,transfer:)

    value_formatted = '0.00'
    if transfer.value.present?
     value_formatted = sprintf('%.2f',transfer.value)
    end

    is_debit = false
    if user.id == transfer.from_user_id
      is_debit = true
    end

    date_format = '%Y-%m-%d %H:%M'

    created_at_formatted = ''
    if transfer.created_at.present?
      created_at_formatted = transfer.created_at.strftime(date_format)
    end

    updated_at_formatted = ''
    if transfer.updated_at.present?
      updated_at_formatted = transfer.updated_at.strftime(date_format)
    end

    is_promotion = false
    if transfer.promotion_id.present?
      is_promotion = true
    end

    obj = {
      from_user_id:transfer.from_user_id,
      to_user_id:transfer.to_user_id,
      from_user_email:transfer.from_email,
      from_user_name:transfer.from_name,
      to_user_email:transfer.to_email,
      to_user_name:transfer.to_name,
      created_at:transfer.created_at,
      created_at_formatted:created_at_formatted,
      updated_at:transfer.updated_at,
      updated_at_formatted:updated_at_formatted,
      value:transfer.value,
      value_formatted:value_formatted,
      is_debit:is_debit,
      promotion_label:transfer.promotion_label,
      is_promotion:is_promotion
    }

    return obj
  end

end
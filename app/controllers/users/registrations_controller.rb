###
# Controller: Users::RegistrationsController
#
# @author Carl Anderson
###
class Users::RegistrationsController < Devise::RegistrationsController


  def create
    super do |resource|
      promotion = Promotion.where('is_active=? AND promotion_type=?',true,Promotion::SIGN_UP_PROMOTION).take

      if promotion.present?
        begin
          transfer = Transfer.new
          transfer.promotion_id = promotion.id
          transfer.value = promotion.value
          transfer.to_user_id = resource.id
          transfer.save

          if transfer.id.present?
            resource.balance += transfer.value
            resource.save
          end

        rescue Exception => e
          Rails.logger.debug e
        end

      end
    end
  end


  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

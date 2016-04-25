class PasswordsController < Devise::PasswordsController
	def create
		super do |resource|
			flash[:alert] = t('activerecord.attributes.user.email') + t('errors.messages.invalid') if resource.email.nil?
		end
	end
end

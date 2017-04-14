class PasswordsController < Devise::PasswordsController

	layout 'devise'

	def create
		super do |resource|
			flash.now[:alert] = t('activerecord.attributes.user.email') + t('errors.messages.invalid') if resource.email.nil?
		end
	end
end

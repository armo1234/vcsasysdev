class User < ActiveRecord::Base

	include CodeHelper
	before_save {|user| user.email = user.email.downcase}
	before_create :confirmation_token


	validates :username, presence: true,
		uniqueness: {case_sensitive: false},
		length: {minimum: 3, maximum: 25}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email, presence: true,
		length: {maximum: 100},
		uniqueness: {case_sensitive: false},
		format: {with: VALID_EMAIL_REGEX}


	has_secure_password

	def self.search_user(search)
		if connection.adapter_name == 'PostgreSQL'
			if search
				where(["fname || ' ' || lname ILIKE :s", :s => "%#{search}%"])
			else
				all
			end
		else
			if search
				where(["fname || ' ' || lname LIKE :s", :s => "%#{search}%"])
			else
				all
			end
		end
	end

	def email_activate
		self.email_confirmed = true
		self.confirm_token = nil
		save!(:validate => false)
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end


	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	private

	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end
end

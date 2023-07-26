class User < ApplicationRecord

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.encrypted_password = SecureRandom.urlsafe_base64
      #user.name = "guestuser"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
end

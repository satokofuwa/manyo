class ApplicationController < ActionController::Base
  before_action :basic_auth #basic認証
  before_action :login_required
    protect_from_forgery with: :exception #クロスサイトリクエストフォージェリ
      include SessionsHelper

    private
      def basic_auth
        if Rails.env == "production"
          authenticate_or_request_with_http_basic do |username, password|
          username == ENV["MANYO_USER"] && password == ENV["MANYO_PASS"]
          end
        end
      end

      def login_required
        redirect_to new_session_path unless current_user
      end 
end




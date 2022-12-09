class Users::UsersApiController < ApplicationController
    before_action :authenticate_user!
    before_action :current_company

    def current_company
       return current_user.company
    end

end
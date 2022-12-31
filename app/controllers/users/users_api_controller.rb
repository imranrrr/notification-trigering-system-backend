class Users::UsersApiController < ApplicationController
    before_action :authenticate_user!
    before_action :current_company

    def current_company
        if current_user.present?
            return current_user.company
        else
            return Company.find_by(sub_domain: request.domain.split(".")[0])
        end
    end

end
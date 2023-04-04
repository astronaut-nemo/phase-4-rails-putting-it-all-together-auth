class UsersController < ApplicationController
    wrap_parameters format: []
    # POST /signup
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    # GET /me
    def show
        user = find_user
        if user
            render json: user, status: :created
        else
            render json: {error: "Not authorized"}, status: :not_authorized
        end
    end

    private
    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def find_user
        User.find(session[:user_id])
    end
end

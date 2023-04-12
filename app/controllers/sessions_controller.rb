class SessionsController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    # POST /login
    def create
        user = User.find_by(username: params[:username])

        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: ["Username or password not authorized"]}, status: :unauthorized
        end
    end

    # DELETE /logout
    def destroy
        session.delete :user_id
        head :no_content, status: :ok
    end
end

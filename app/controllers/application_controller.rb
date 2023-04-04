class ApplicationController < ActionController::API
  include ActionController::Cookies

  
  # Rescue
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

  private
  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_record_not_found_response
    @model_name = controller_name.classify
    render json: {errors: "#{@model_name} not found"}, status: :not_found
  end

end

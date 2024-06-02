class MealPlansController < ApplicationController
  before_action :authorize_request

  def create
    meal_plan = @current_user.meal_plans.build(meal_plan_params)
    if meal_plan.save
      render json: meal_plan, status: :created
    else
      render json: { errors: meal_plan.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    meal_plans = @current_user.meal_plans
    render json: meal_plans, status: :ok
  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:name, :diet, :calorie_target, :num_meals)
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end

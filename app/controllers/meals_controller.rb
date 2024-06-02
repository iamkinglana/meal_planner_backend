class MealsController < ApplicationController
  before_action :authorize_request
  before_action :set_meal_plan

  def create
    meal = @meal_plan.meals.build(meal_params)
    if meal.save
      render json: meal, status: :created
    else
      render json: { errors: meal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :calories, :ingredients)
  end

  def set_meal_plan
    @meal_plan = MealPlan.find(params[:meal_plan_id])
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

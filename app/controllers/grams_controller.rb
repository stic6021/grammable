class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to(root_path)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @gram = Gram.new
  end

  def show
    render :show, status: :not_found if current_gram.nil?
  end

  private

  helper_method :current_gram
  def current_gram
    @current_gram ||= Gram.find(params[:id]) rescue nil
  end

  def gram_params
    params.require(:gram).permit(:message)
  end
end

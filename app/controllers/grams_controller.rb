class GramsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @gram = Gram.create(gram_params)
    if @gram.valid?
      redirect_to(root_path)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @gram = Gram.new
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end
end

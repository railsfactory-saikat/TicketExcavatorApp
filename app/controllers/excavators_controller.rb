# frozen_string_literal: true

class ExcavatorsController < ApplicationController
  def index
    @excavators = Excavator.all
  end

  def show
    @excavator = Excavator.find(params[:id])
  end
end

class CollectionRedirectController < ApplicationController

  def index
    redirect_to exhibits_path
  end

  def show
    redirect_to CollectionRedirect.call(params[:id])
  end

end

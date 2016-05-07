class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @isAdmin = is_admin?
    if @isAdmin
      if params[:query]
        @contacts = Contact.page(params[:page]).per_page(9)
      end
    else
      @contacts= Contact.page(params[:page]).per_page(9)
    end
    @contacts= Contact.page(params[:page]).per_page(9)
  end

  def search
  end

  private
  def is_admin?
    current_user.email=="admin@admin.com"
  end
  
end

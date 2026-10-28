class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def not_found
    render_not_found
  end
end

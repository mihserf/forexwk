class AdminController < ApplicationController
  before_filter :admin_required
end

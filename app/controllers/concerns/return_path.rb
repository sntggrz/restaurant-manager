# app/controllers/concerns/return_path.rb
module ReturnPath
  def back_to_dashboard? = params[:from] == "dashboard"
end

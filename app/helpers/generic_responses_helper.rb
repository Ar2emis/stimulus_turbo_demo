module GenericResponsesHelper
  def from?(action)
    params[:from].to_s.to_sym == action
  end
end

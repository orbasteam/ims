module ModelSupport

  def model_name
    controller_name.classify
  end

  def model
    model_name.constantize
  end

end
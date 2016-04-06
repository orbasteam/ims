module Savable

  extend ActiveSupport::Concern
  include ModelSupport

  included do
    before_action :set_resource, only: [:edit, :update]
    before_action :set_empty_resource, only: [:new]
  end

  def new
    render_form_template
  end

  def create

    set_var(model.new(strong_params))

    begin
      get_var.save!

      if request.xhr?
        render json: get_var
      else
        flash[:success] = I18n.t('form.saved')
        redirect_to(params[:save_next] ? new_path : edit_path(get_var))
      end

    rescue Exception => e
      after_save(e)
    end

  end

  def edit
    render_form_template
  end

  def update

    begin

      get_var.update! strong_params

      if request.xhr?
        render json: get_var
      else
        flash[:success] = I18n.t('form.saved')
        redirect_to edit_path(get_var)
      end

    rescue Exception => e
      after_save(e)
    end

  end

  private

  def after_save(exception)

    if request.xhr?
      render json: { message: exception.message }, status: :unprocessable_entity
    else
      flash.now[:alert] = exception.message
      render_form_template
    end

  end

  def render_form_template
    render :form
  end

  def new_path
    path = ['new', module_name, model_name.underscore, 'path'].compact
    send(path.join('_'))
  end

  def edit_path(param)
    path = ['edit', module_name, model_name.underscore, 'path'].compact
    send(path.join('_'), param)
  end

  def strong_params
    raise NotImplementedError
  end

  def set_var(value)
    self.instance_variable_set(attr_name, value)
  end

  def get_var
    self.instance_variable_get(attr_name)
  end

  def attr_name
    "@#{model_name.underscore}"
  end

  def module_name
    @module_name ||= if self.class.name.index(':')
      self.class.name.split("::").first.underscore
    else
      nil
    end
  end

  def set_resource
    set_var(model.find(params[:id]))
  end

  def set_empty_resource
    set_var(model.new)
  end

end
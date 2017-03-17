class Admin::PaymentMethodsController < Admin::BaseController
  before_action :set_payment_method, except: [:index, :new, :create]

  def index
    @payment_methods = PaymentMethod.all
  end

  def show
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def edit
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)

    if @payment_method.save
      redirect_to admin_payment_methods_path, notice: 'El método de pago fue creado.'
    else
      render :new
    end
  end

  def update
    if @payment_method.update(payment_method_params)
      redirect_to admin_payment_methods_path, notice: 'El método de pago fue actualizado.'
    else
      render :edit
    end
  end

  def destroy
    @payment_method.update_attribute(:deprecated, true)
    redirect_to admin_payment_methods_path, notice: 'El método de pago fue borrado.'
  end

  def toggle
    # direct db update
    @payment_method.toggle!(:active)
    redirect_to :back
  end

  private
    
    def set_payment_method
      @payment_method = PaymentMethod.find(params[:id])
    end

    def payment_method_params
      params.require(:payment_method).permit(
        :name, :method, :schedule, :instructions, :notice, 
        :active, :details, :expires, :image, bank_ids: []
      )
    end

end

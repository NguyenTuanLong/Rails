class ApplicationController < ActionController::Base
    
    private
    def current_cart
        user = current_user
        user.carts.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        user=current_user
        cart = user.carts.create
        session[:cart_id] = cart.id
        cart
    end

    helper_method :current_cart
end

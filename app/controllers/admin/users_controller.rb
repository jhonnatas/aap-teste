module Admin
  class UsersController < BaseController
    before_action :authenticate_user!
    before_action :load_user, only: [ :show, :edit, :update, :destroy ]
    def index
      @pagy, @users = pagy(User.all)
    end

    def edit
      authorize @user
    end

    def show;end

    def new
      @user = User.new
      authorize @user
    end

    def create
      @user = User.new user_params
      authorize @user
      if @user.save
        redirect_to admin_users_path, notice: "Usuário cadastrado com sucesso!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @user
      if @user.update user_params
        redirect_to admin_users_path, notice: "Usuário atualizado com sucesso!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @user
      @user.destroy
      redirect_to admin_users_path, notice: "Usuário excluido com sucesso!"
    end

    private

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
  end
end

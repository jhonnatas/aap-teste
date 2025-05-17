module Admin::RegistrationsHelper
  def user_selection_field(form)
    if form.object.persisted?
      # Para registros existentes, mostra o email do usuário associado
      user_email = User.find(form.object.user_id).email
      form.input :user_id, as: :string, input_html: { value: user_email, readonly: true }
    else
      # Para novos registros, mostra um select de usuários
      form.input :user_id, collection: @users.map { |user| [user.email, user.id] },
                          include_blank: false
    end
  end
end

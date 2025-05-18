class CertificateGenerator
 def initialize(user, event)
    @user = user
    @event = event
    @activities = user.activities.where(event: event)
  end

  def generate_and_save
    Certificate.create!(user: @user, event: @event, issued_at: Time.current).tap do |certificate|
      generate_pdf(certificate)
    end
  end

  private

  def generate_pdf(certificate)
    Prawn::Document.new do |pdf|
      pdf.text "Certificado de Participação", size: 30, style: :bold
      pdf.move_down 20
      pdf.text "Certificamos que #{@user.name} participou do evento #{@event.name}."
      pdf.text "Número do Certificado: #{certificate.certificate_number}"
      pdf.move_down 10
      pdf.text "Atividades Participadas:", size: 18, style: :bold
      list_activities(pdf)
    end.render
  end

  def list_activities(pdf)
    @activities.each_with_index do |activity, index|
      pdf.text "#{index + 1}. #{activity.name} - #{activity.period_start.strftime('%d/%m/%Y %H:%M')}"
    end
  end
end

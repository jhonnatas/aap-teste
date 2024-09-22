# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Criando usuários
admin = User.create!(
  email: "admin@example.com",
  password: "123456",
  role: "admin"
)

event_owner = User.create!(
  email: "dono@example.com",
  password: "123456",
  role: "manager"
)

participant = User.create!(
  email: "participante@example.com",
  password: "123456",
  role: "registered"
)

# Criação de eventos pelo dono do evento
event1 = Event.create!(
  name: "Evento de Tecnologia",
  local: "Auditório Central",
  period_start: DateTime.now,
  period_end: DateTime.now + 2.days,
  email: "tech@evento.com",
  responsable: "João Silva",
  txtEnter: "Um evento voltado para novas tecnologias.",
  txtAbout: "Discussões sobre o futuro da tecnologia e workshops práticos.",
  comission: "Comissão de Tecnologia",
  primaryColor: "#FF5733",
  secondaryColor: "#C70039",
  status: "registrations_open",
  user: event_owner # Relaciona o evento com o dono
)

event2 = Event.create!(
  name: "Conferência de Negócios",
  local: "Salão Nobre",
  period_start: DateTime.now + 5.days,
  period_end: DateTime.now + 7.days,
  email: "negocios@evento.com",
  responsable: "Maria Oliveira",
  txtEnter: "Um evento para empreendedores e empresários.",
  txtAbout: "Discussões sobre inovação e crescimento de empresas.",
  comission: "Comissão de Negócios",
  primaryColor: "#28A745",
  secondaryColor: "#17A2B8",
  status: "event_in_progress",
  user: event_owner # Relaciona o evento com o dono
)

# Criação de atividades para os eventos
Activity.create!(
  name: "Palestra sobre IA",
  title: "Inteligência Artificial: O Futuro",
  speaker: "Carlos Andrade",
  period_start: DateTime.now + 5.days,
  local: "Sala 101",
  certificate_hours: "2",
  subscriptions_open: true,
  event: event1
)

Activity.create!(
  name: "Workshop de Blockchain",
  title: "Entendendo a Blockchain",
  speaker: "Fernanda Souza",
  period_start: DateTime.now + 1.days,
  local: "Sala 102",
  certificate_hours: "3",
  subscriptions_open: true,
  event: event1
)

Activity.create!(
  name: "Mesa Redonda de Negócios",
  title: "Desafios do Empreendedorismo",
  speaker: "Vários",
  period_start: DateTime.now + 1.days,
  local: "Sala Principal",
  certificate_hours: "1",
  subscriptions_open: true,
  event: event2
)

Activity.create!(
  name: "Palestra de Marketing Digital",
  title: "O Futuro do Marketing",
  speaker: "Ana Clara",
  period_start: DateTime.now,
  local: "Sala Secundária",
  certificate_hours: "2",
  subscriptions_open: true,
  event: event2
)

puts "Seed data loaded successfully!"

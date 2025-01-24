# frozen_string_literal: true
class PresenceListPdf < Prawn::Document  
  def initialize(students, activity)  
    super()  
    @students = students 
    @activity = activity
    header  
    student_list  
  end  

  #pdf = Prawn::Document.new(page_size: "A4", top_margin: 80, bottom_margin: 40)   

  def header     
    move_down 5  

    indent(2) do
      text "Lista de Presença", size: 15, style: :bold, align: :center
      text "Evento: #{@activity.event.name}", size: 11,  style: :bold
      text "Atividade: #{@activity.name}", size: 11,style: :bold 
      text "Início: #{@activity.period_start.strftime('%d/%m/%Y %H:%M:%S')}",size: 11, style: :bold
      text "Fim: #{@activity.period_end.strftime('%d/%m/%Y %H:%M:%S')}", size: 11, style: :bold
      text "Total de inscritos: #{@students.count}", size: 11, style: :bold      
    end      
    move_down 9  

    bounding_box([0, 700], width: 539, height: 70) do
      stroke_bounds     
    end

    move_down 5   
  end  

  def student_data
    ordered_data = @students.sort_by { |dado| dado[:email] }    
    [["Id", "Email", "Assinatura"]] + ordered_data.map { |student| [student.id, student.email, nil] }  
  end  

  def student_list  
    table student_data do  
      row(0).font_style = :bold  
      columns(2).width = 300 
      self.cell_style = { size: 10 }
      self.row_colors = ["DDDDDD", "FFFFFF"]      
     end  
  end 
end  
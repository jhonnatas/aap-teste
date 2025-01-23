class AlunosPdf < Prawn::Document  
  def initialize(alunos)  
    super()  
    @alunos = alunos  
    header  
    alunos_list  
  end  

  def header  
    text "Lista de Presença", size: 20, style: :bold 
    text "Total de inscritos: #{@alunos.count}"     
    move_down 10  
  end  

  def alumno_data  
    [["Id", "Email", "Assinatura"]] + @alunos.asc.map { |aluno| [aluno.id, aluno.email, nil] }  
  end  

  def alunos_list  
    table alumno_data do  
      row(0).font_style = :bold  
      columns(2).width = 250   
      self.row_colors = ["DDDDDD", "FFFFFF"]      
      self.header = true  
    end  
  end 
end  
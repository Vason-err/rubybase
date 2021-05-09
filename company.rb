module Company
  attr_reader :company
  
  def made_by(company)
    self.company = company
  end

  protected
  attr_writer :company
end
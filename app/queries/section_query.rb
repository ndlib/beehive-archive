class SectionQuery

  def all_in_exhibit()
    Section.order(:order)
  end

end

module TaggingHelpers
  def add_tag(tag)
    tag_list.add(tag)
    save
  end

  def remove_tag(tag)
    tag_list.delete(tag)
    save
  end
end

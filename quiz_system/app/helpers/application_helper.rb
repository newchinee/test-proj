module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Quiz System"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def button_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, :param => new_object)
    end
    button_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "btn btn-info btn-medium")
  end
  
  def sortable(model, column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column(model) ? "current #{sort_direction}" : nil
    direction = column == sort_column(model) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end

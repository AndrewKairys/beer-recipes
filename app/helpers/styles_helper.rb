module StylesHelper
  def div_style_class
    if params[:recipe]
      if params[:recipe][:style_id] == ""
        "field_with_errors"
      else
        ""
      end
    else
      ""
    end    
  end

end

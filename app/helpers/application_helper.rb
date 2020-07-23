module ApplicationHelper
  def calculate_time_left(time)
    distance_of_time_in_words(time, DateTime.now)
  end

  def i18n_enum(model_name, enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

  def enum_collection(model_name, enum_name)
    @model = model_name.capitalize.constantize
    @model.send(enum_name.to_s.pluralize).keys.map { |val| [i18n_enum(model_name, enum_name, val), val] }
  end
end

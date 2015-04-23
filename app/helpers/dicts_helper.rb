module DictsHelper
  def get_dict_by_type(type)
    Dict.find_all_by_dict_type(type)
  end
  
  def get_dict_by_id(id)
    Dict.find(id)
  end
  
  def get_dict(dict_typecode)
    Dict.find_by_dict_type_and_code(dict_typecode)
  end
end
module SimpleEav
  module ClassMethods
    def configure_simple_eav(column)
      @@column = column.to_sym
      serialize @@column
    end

    def simple_eav_column; @@column end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def simple_eav_column
    self.class.simple_eav_column 
  end
  
  def actual_columns_of_table
    self.class.columns.map{|col| col.name.to_sym }
  end

  def simple_eav_attributes
    self.send(simple_eav_column.to_sym) || {}
  end

  def simple_eav_attributes=(attributes={})
    self.send("#{simple_eav_column}=", attributes)
  end
  
  def attributes=(_attributes={})
    #Iterate over each attribute:
    # - skip columns that are actually defined in the db
    # - remove undefined columns to prevent UnknownAttribute::Error from being thrown    
    simple_eav_attrs = read_attribute(simple_eav_column.to_sym) || {}
    _attributes.each do |column,value|
      next if actual_columns_of_table.include?(column)
      simple_eav_attrs[column] = value 
      _attributes.delete(column)
    end
    self.simple_eav_attributes = simple_eav_attrs
    super(_attributes)
  end

  def respond_to?(method, include_private=false)
    super || simple_eav_attributes.has_key?(method)
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /=$/
      _attributes = self.simple_eav_attributes
      setter = method.to_s.gsub(/=/, '')
      _attributes[setter.to_sym] = args.shift
      self.simple_eav_attributes = _attributes
    elsif simple_eav_attributes.has_key?(method.to_sym)
      simple_eav_attributes[method.to_sym]
    else
      super(method, *args, &block)
    end
  end
end

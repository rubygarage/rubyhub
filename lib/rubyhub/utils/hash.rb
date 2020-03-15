class Hash
  def except(*keys)
    slice(*self.keys - keys)
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end
end

module MapLocatable
  extend ActiveSupport::Concern

  def map_location
    return map_address || location
  end

  private

  def map_address
    return nil unless complete_address?
    plusserize("#{ address },#{ city },#{ state },#{ postal_code }")
  end

  def complete_address?
    address.present? && city.present?
  end

  # replace spaces with plusses
  def plusserize(str)
    str.gsub(' ', '+')
  end
end

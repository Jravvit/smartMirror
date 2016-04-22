class WeatherSerializer < ActiveModel::Serializer
  belongs_to :area
  attributes :id, :date, :image, :state, :temp, :hour, :area_id
end

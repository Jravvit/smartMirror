class WeatherSerializer < ActiveModel::Serializer
  attributes :id, :date, :image, :state, :temp, :hour
end

# frozen_string_literal: true

class ScheduleDecorator
  def initialize(hash)
    @hash = hash
  end

  def as_json(*)
    hash.each_with_object([]) do |(day, collection), array|
      array << { day => collection.values }
    end
  end

  private

  attr_reader :hash
end

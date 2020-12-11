class Outcome
  def self.Success(value)
    Success.new(value)
  end

  def self.Failure(error)
    Failure.new(error)
  end
end

class Result
  attr_reader :value, :error

   def initialize(value:, error:)
    @value = value
    @error = error
  end

   def success?
    error.nil?
  end

   def failure?
    !success?
  end
end

class Success < Result
  def initialize(value)
    super(value: value, error: nil)
  end
end

class Failure < Result
  def initialize(error)
    super(error: error, value: nil)
  end
end

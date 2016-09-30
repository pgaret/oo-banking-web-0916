class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender, @receiver, @amount = sender, receiver, amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if !@sender.valid? || @sender.balance < @amount then
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif @status == "pending" then
      @status = "complete"
      @sender.withdraw(@amount)
      @receiver.deposit(@amount)
    else "This transaction is totally worthless!"
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(@amount)
      @receiver.withdraw(@amount)
      @status = "reversed"
    end
  end
end

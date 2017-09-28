module ApplicationHelper
  def format_amount(number)
    '$' + sprintf('%.2f', number)
  end

  def format_date_with_time(date)
    date.in_time_zone('America/Los_Angeles').strftime("%I:%M%p %d/%m/%Y")
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_payment_method(payment_method)
    payment_method.payment_type == 'Cash' ? 'Cash' : "#{payment_method.bank} - #{payment_method.payment_type} (xx#{payment_method.last_four_digits})"
  end
end

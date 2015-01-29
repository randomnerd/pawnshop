class ItemMailer < ApplicationMailer
  def approved_email(item)
    @item = item
    mail to: @item.email, subject: 'Your item was approved at pawnshop'
  end

  def declined_email(item)
    @item = item
    mail to: @item.email, subject: 'Your item was declined at pawnshop'
  end
end

class Item < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :title
  validates_presence_of :image

  scope :pending,       -> { where status: 0 }
  scope :approved,      -> { where status: 1 }
  scope :declined,      -> { where status: 2 }
  scope :not_declined,  -> { where 'status IS NOT 2' }
  scope :title_search,  -> (q) { where('title like ?', "%#{q}%") }

  has_attached_file :image, styles: { big: '500x500#', thumb: '290x290#', admin_thumb: '100x100#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  after_update :send_email

  def decline!
    update_attribute :status, 2
    ItemMailer.declined_email(self).deliver_later
  end

  def pending?
    status == 0
  end

  def text_status(status=nil)
    status ||= self.status
    case status
    when 0 then 'Waiting for approval'
    when 1 then 'Approved'
    when 2 then 'Declined'
    end
  end

  def send_email
    return unless status_changed?
    case status
    when 1 then ItemMailer.approved_email(self).deliver_later
    when 2 then ItemMailer.declined_email(self).deliver_later
    end
  end
end

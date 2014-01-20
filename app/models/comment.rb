class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user

  validates_presence_of :body

  after_save :change_issue_status

  def author
    if user.present?
      user.username
    else
      issue.reporter_name
    end
  end

  def change_issue_status
    if self.user_id.present?
      self.issue.staff_response!
    else
      self.issue.customer_response!
    end
  end

end

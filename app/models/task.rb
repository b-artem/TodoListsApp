class Task < ApplicationRecord
  belongs_to :todo_list

  default_scope -> { order(priority: :asc) }
  validates :body, presence: true, length: { minimum: 1, maximum: 80 }
  validates :todo_list_id, presence: true
  validates :priority, presence: true
  validates_numericality_of :priority, only_integer: true, greater_than_or_equal_to: 0
  validates :deadline, presence: true

  def next
    self.class.where("todo_list_id = ? AND priority > ?", todo_list_id, priority).first
  end

  def prev
    self.class.where("todo_list_id = ? AND priority < ?", todo_list_id, priority).last
  end

end

class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates_associated :tasks
  default_scope -> { order(updated_at: :desc) }
  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :user_id, presence: true
end

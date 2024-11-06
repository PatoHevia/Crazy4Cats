class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validación para que un usuario solo pueda reaccionar una vez por post
  validates :user_id, uniqueness: { scope: :post_id, message: "solo puede reaccionar una vez a cada publicación" }
end

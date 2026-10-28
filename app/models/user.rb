class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  ROLES = { "owner" => "Владелец", "admin" => "Администратор", "marketer" => "Маркетолог", "developer" => "Разработчик" }

  has_many :memberships, dependent: :destroy
  has_many :workspaces, through: :memberships
  has_many :owned_workspaces, class_name: "Workspace", foreign_key: :owner_id, dependent: :destroy
  has_many :invited_memberships, class_name: "Membership", foreign_key: :invited_by, dependent: :nullify
  has_many :notifications, dependent: :destroy
  has_many :conversations, dependent: :destroy

  has_many :assigned_tasks, class_name: "Task", foreign_key: :assignee_id, dependent: :nullify
  has_many :created_tasks, class_name: "Task", foreign_key: :created_by, dependent: :destroy
  has_many :added_competitors, class_name: "Competitor", foreign_key: :added_by, dependent: :destroy

  validates :name, presence: true
  validates :role, inclusion: { in: ROLES.keys }
  attr_accessor :terms

  validates :terms, acceptance: { message: "нужно принять" }

  def role_name
    ROLES[role]
  end

  def initials
    name.split.map(&:first).first(2).join
  end
end

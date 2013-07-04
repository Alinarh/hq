class Group < ActiveRecord::Base
  self.table_name = 'group'

  alias_attribute :id,     :group_id
  alias_attribute :course, :group_course
  alias_attribute :number, :group_number

  belongs_to :speciality, primary_key: :speciality_id, foreign_key: :group_speciality

  has_many :students, foreign_key: :student_group_group
  has_many :exams, foreign_key: :exam_group
  has_many :subjects, foreign_key: :subject_group

  scope :from_speciality, -> speciality { where(group_speciality: speciality) }
  scope :from_course, -> course { where(group_course: course) }
  scope :from_form, -> form { where(group_form: form) }
  scope :from_faculty, -> faculty {
    joins(:speciality).where(speciality: { speciality_faculty: faculty })
  }

  scope :filter, -> filters {
    cond = all

    if filters.key?(:speciality) && !filters[:speciality].empty?
      cond = cond.from_speciality(filters[:speciality])
    end

    if filters.key?(:course) && !filters[:course].empty?
      cond = cond.from_course(filters[:course])
    end

    if filters.key?(:form) && !filters[:course].empty?
      cond = cond.from_form(filters[:form])
    end

    if filters.key?(:faculty) && !filters[:course].empty?
      cond = cond.from_faculty(filters[:faculty])
    end

    cond
  }

  def name
    n = []

    n << 'Б' if speciality.bachelor?
    n << 'М' if speciality.master?

    n << "-#{course}-#{number}"
    n.join
  end

end
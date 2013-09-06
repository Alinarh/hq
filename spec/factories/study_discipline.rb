require 'faker'

FactoryGirl.define do
  factory :discipline, class: Study::Discipline do
    subject_year		  { Date.today.year }
    subject_semester  { 1 + rand(1) }
    subject_name      { Faker::Lorem.sentence }

    group
    association :lead_teacher, factory: :user, strategy: :build
    association :final_exam,   factory: [:exam, :final], strategy: :build

    #after(:build) do |discipline|
    #  discipline.final_exams << FactoryGirl.build(:final_exam, study_discipline: discipline)
    #end
    #
    #factory :discipline_with_checkpoints, parent: :study_discipline do
    #  after(:build) do |discipline|
    #    discipline.checkpoints << FactoryGirl.build(:checkpoint, checkpoint_subject: discipline)
    #  end
    #end
    #
    #factory :discipline_with_controls, parent: :discipline do
    #  after(:build) do |discipline|
    #    4.times do
    #      discipline.checkpoints << FactoryGirl.build(:checkpoint_control, checkpoint_subject: discipline)
    #    end
    #  end
    #end
  end
end
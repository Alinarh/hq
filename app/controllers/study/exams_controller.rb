class Study::ExamsController < ApplicationController
  before_filter :load_discipline
  load_and_authorize_resource :discipline
  load_and_authorize_resource through: :discipline, except: :create

  def index ; end

  def new ; end

  def edit ; end

  def show ; end

  def update
    #raise resource_params.inspect
    @exam.update(resource_params)
    if @exam.save
      redirect_to study_discipline_checkpoints_path(@discipline)
    end
  end

  def updatedate
    @exam.update(resource_params)
    redirect_to study_plans_path(faculty: @exam.discipline.group.speciality.faculty.id,
                                 speciality: @exam.discipline.group.speciality.id,
                                 course: @exam.discipline.group.course,
                                 form: @exam.discipline.group.form,
                                 group: @exam.discipline.group.id)
  end

  def destroy
    @exam.destroy
    redirect_to study_plans_path(faculty: @exam.discipline.group.speciality.faculty.id,
                                 speciality: @exam.discipline.group.speciality.id,
                                 course: @exam.discipline.group.course,
                                 form: @exam.discipline.group.form,
                                 group: @exam.discipline.group.id)
  end

  def create
    exam = params[:study_exam]
    if exam.include?(:exam_group)
      #raise resource_params.inspect
      @exam = Study::Exam.create(resource_params)
    elsif exam.include?(:exam_student_group)
      @exam = Study::Exam.create exam_subject: exam[:exam_subject], parent: exam[:parent], exam_type: exam[:exam_type],
                                 weight: exam[:weight], exam_student: exam[:exam_student], exam_student_group: exam[:exam_student_group],
                                 repeat: exam[:repeat], date: exam[:date]
    end
    redirect_to study_plans_path(faculty: @exam.discipline.group.speciality.faculty.id,
                                 speciality: @exam.discipline.group.speciality.id,
                                 course: @exam.discipline.group.course,
                                 form: @exam.discipline.group.form,
                                 group: @exam.discipline.group.id)
  end

  def print
    @exam = Study::Exam.find(params[:exam_id])
    load_discipline
    respond_to do |format|
      format.pdf
    end
  end

  def resource_params
    params.fetch(:study_exam, {}).permit( :id, :date, :exam_subject, :parent, :exam_type, :weight, :exam_group, :exam_student, :exam_student_group, :repeat,
                                          final_marks_attributes: [:id, :mark_date, :mark_student_group, :mark_value, :mark_final],
                                          rating_marks_attributes: [:id, :mark_date, :mark_student_group, :mark_value, :mark_rating, :mark_final],
                                          students_attributes: [:id, :exam_student_student, :exam_student_student_group, :'_destroy']
    )
  end

  private

  def load_discipline
    @discipline = Study::Discipline.find(params[:discipline_id])
  end
end
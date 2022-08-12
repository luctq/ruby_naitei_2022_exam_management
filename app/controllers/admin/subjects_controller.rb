class Admin::SubjectsController < Admin::BaseController
  before_action :find_subject, except: %i(index new create)

  def index
    @pagy, @subject_item = pagy Subject.all, items: Settings.pagy
  end

  def new
    @subject = Subject.new
    return if @subject

    flash.now[:error] = t "not_found"
    redirect_to root_path
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t ".success_create"
      redirect_to admin_subjects_path
    else
      flash.now[:error] = t ".fail_create"
      render :new
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t ".subject_deleted"
    else
      flash[:danger] = t ".subject_delete_fail"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit Subject::SUBJECT_ATTRS
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject.present?

    flash[:danger] = t "not_found"
    redirect_to admin_subjects_path
  end
end

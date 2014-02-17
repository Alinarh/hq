class EventsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :actual
  load_resource except: :actual
  authorize_resource :event, except: :actual
  def index
    @events = @events.no_booking  # Пока так, чтобы ничего лишнего не смотрели
    @events = @events.from_name(params[:name]) if params[:name]
  end

  def actual
    authorize! :actual, :events
    @events = Event.no_booking
    unless params[:year] || params[:month]
      redirect_to actual_events_path(year: Date.today.year, month: Date.today.month, name: params[:name])
    end
    @year = params[:year].to_i
    @month = params[:month].to_i
    day = params[:day]

    @dates = []
    @events.each do |event|
      @dates << event.dates.collect{|d| (l d.date, format: '%d.%m.%Y')}
    end
    @dates = @dates.flatten.uniq.sort_by{|d| d,m,y=d.split('.');[y,m,d]}

    @events = @events.from_name(params[:name]) if params[:name]

    if day
      @selected_day = "#{day}.#{@month}.#{@year}"
      search_dates = []
      @events.each do |e|
        search_dates << e.dates.from_date(@selected_day)
      end
      @events = search_dates.flatten.collect{ |sd| sd.event }.uniq
    end
  end

  def show
    @visitor = VisitorEventDate.new
  end

  def new
  end

  def create
    @event = Event.new(resource_params)
    if @event.save
      redirect_to events_path, notice: 'Событие успешно добавлено.'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @event.update(resource_params)
      redirect_to events_path, notice: 'Изменения сохранены.'
    else
      render action: :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, notice: 'Событие было удалено.'
  end

  def print
    respond_to do |format|
      format.pdf
    end
  end

  def resource_params
    params.fetch(:event, {}).permit(:name, :description, :booking, :event_category_id,
                 dates_attributes: [:id, :date, :time_start, :time_end, :max_visitors, :'_destroy'])
  end
end
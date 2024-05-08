class MoviesController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    @movie_new = Movie.new
    @movies = Movie.all.order("#{sort_column} #{sort_direction}")
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:success] = 'Created successfully.'
      redirect_to movies_path
    else
      @movies = Movie.all
      @movie_new = Movie.new
      render :index
    end
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:success] = 'Updated successfully.'
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:success] = 'Destroyed successfully.'
    redirect_to movies_path
  end

  def import
    if params[:file]
      Movie.import(params[:file])
      flash[:success] = 'Imported successfully.'
      redirect_to movies_path
    else
      flash[:danger] = 'No file chosen.'
      redirect_to movies_path
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:mode, :title, :score, :summary)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'  
  end

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end

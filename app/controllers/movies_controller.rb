class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    # 3/ ---------- Recherche dans le titre et le synopsie + dans la table reference ----------
    if params[:query].present?
      sql_subquery = <<~SQL
        movies.title ILIKE :query
        OR movies.synopsis ILIKE :query
        OR directors.first_name ILIKE :query
        OR directors.last_name ILIKE :query
      SQL
      @movies = @movies.joins(:director).where(sql_subquery, query: "%#{params[:query]}%")
    end
    # 3/ ---------- -------------------------------- ----------

    # 2/ ---------- Recherche dans le titre et le synopsie ----------
    # if params[:query].present?
    #   sql_subquery = "title ILIKE :query OR synopsis ILIKE :query"
    #   @movies = @movies.where(sql_subquery, query: "%#{params[:query]}%")
    # end
    # 2/ ---------- -------------------------------- ----------

    # 1/ ---------- Recherche dans le titre seulment ----------
    # if params[:query].present?
    #   @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%") permet de
    # end
    # 1/ ---------- -------------------------------- ----------

  end

end

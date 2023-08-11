class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    # 4/ ---------- Permet la recherche entre plusieures mots entier seulelment dans les deux tables ----------
    # if params[:query].present?
    #   sql_subquery = <<~SQL
    #     movies.title @@ :query
    #     OR movies.synopsis @@ :query
    #     OR directors.first_name @@ :query
    #     OR directors.last_name @@ :query
    #   SQL
    #   @movies = @movies.joins(:director).where(sql_subquery, query: params[:query])
    # end
    # 4/ ---------- -------------------------------- ----------

    # 3/ ------ Recherche dans la table Movies le titre et le synopsie + dans la table reference Directors les noms ------
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

    # 2/ ---------- Recherche dans la table Movies le titre et le synopsie ----------
    # if params[:query].present?
    #   sql_subquery = "title ILIKE :query OR synopsis ILIKE :query"
    #   @movies = @movies.where(sql_subquery, query: "%#{params[:query]}%")
    # end
    # 2/ ---------- -------------------------------- ----------

    # 1/ ---------- Recherche dans la table Movies le titre simplifié ----------
    # if params[:query].present?
    #   @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%") permet de
    # end
    # 1/ ---------- -------------------------------- ----------

    # 0/ ---------- Recherche dans la table Movies le titre entier seulment ----------
    # if params[:query].present?
    #   @movies = @movies.where(title: params[:query])
    # end
    # 0/ ---------- -------------------------------- ----------

  end

end

class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
  end

  def destroy
  end
end

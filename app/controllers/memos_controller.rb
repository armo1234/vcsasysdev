# Controller for the memo

class MemosController < ApplicationController

	# Calls the set_memo method before executing edit, update, show or destroy actions
	before_action :set_memo, only: [:edit, :update, :show, :destroy]
	before_action :require_user

	def index
		@memo = Memo.where(:user_id => current_user.id)
	end

	def new
		@memo = Memo.new
	end

	def create
		@memo = Memo.new(memo_params)
		@memo.user_id = current_user.id
		if @memo.save
			flash[:success] = "New memo added"
			redirect_to memo_path(@memo)
		else
			render 'new'
		end
	end

	def show
		if current_user.admin != true and current_user.id != @memo.user_id
            flash[:danger] = "You cannot edit or delete other people's accounts"
            redirect_to root_path
        end
	end

	def edit
		if current_user.admin != true and current_user.id != @memo.user_id
            flash[:danger] = "You cannot edit or delete other people's accounts"
            redirect_to root_path
        
    	else
    		render 'edit'
    	end
	end

	def update

		if @memo.update(memo_params)
			flash[:success] = "Memo updated"
			redirect_to memo_path(@memo)
		else
			render 'edit'
		end
	end

	def destroy
		@memo.destroy
		flash[:danger] = "Memo was deleted"
		redirect_to memos_path
	end

	private
	# Sets the memo variable to the selected memo
	def set_memo
		@memo = Memo.find(params[:id])
	end

	# Assigns the parameters entered while creating or editing a memo
	def memo_params
		params.require(:memo).permit(:description)
	end
end
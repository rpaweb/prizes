class PrizesController < ApplicationController
  before_action :set_prize, only: [:show, :edit, :update, :destroy]
  before_action :set_rules, except: :destroy
  before_action :authenticate_user!

  def index
    @prizes = Prize.all.order(created_at: :asc)
  end

  def show
  end

  def new
    if Rule.all.blank?
      redirect_to new_rule_path, alert: 'There are no rules. You need to create at least 1 rule to start setting up prizes.'
    else
      @prize = Prize.new
    end
  end

  def edit
  end

  def create
    @prize = Prize.new(prize_params)

    if @prize.save
      redirect_to @prize, notice: 'Prize was successfully created.'
    else
      redirect_to new_prize_path, alert: "Oh snap! You got #{@prize.errors.count} #{"error".pluralize(@prize.errors.count)} in your attempt to add a new prize: #{@prize.errors.full_messages.join(", ")}!"
    end
  end

  def update
    if @prize.update(prize_params)
      redirect_to @prize, notice: 'Prize was successfully updated.'
    else
      redirect_to edit_prize_path(@prize), alert: "Oh snap! You got #{@prize.errors.count} #{"error".pluralize(@prize.errors.count)} in your attempt to update this prize: #{@prize.errors.full_messages.join(", ")}!"
    end
  end

  def destroy
    @prize.destroy
    redirect_to prizes_url, notice: 'Prize was successfully destroyed.'
  end

  private
    def set_prize
      @prize = Prize.find(params[:id])
    end

    def set_rules
      @rules = Rule.all.map { |rule|
        [
          [
            if rule.multipleof && rule.specific
              "Multiple Of #{rule.multipleof} After #{rule.specific}"
            elsif rule.multipleof
              "Multiple Of #{rule.multipleof}"
            else
              "Subscriber No. #{rule.specific}"
            end
          ][0],
          rule.id
        ]
      }
    end

    def prize_params
      params.require(:prize).permit(:name, :desc, :amount, :photo, :rule_id)
    end
end
